//
//  AppConfiguration.swift
//  safeRide Watch App
//
//  Created by Alexander Boswell on 2/18/23.
//

import Combine
import SoundAnalysis
import SwiftUI

enum SensitivityLevel: String, CaseIterable  {
	case low = "Low"
	case medium = "Medium"
	case high = "High"
	
	var detectedValue: CGFloat {
		switch self {
			case .low:
				return 0.8
			case .medium:
				return 0.65
			case .high:
				return 0.5
		}
	}
}


/// Contains customizable settings that control app behavior.
struct AppConfiguration {
	/// Indicates the amount of audio, in seconds, that informs a prediction.
	var inferenceWindowSize = Double(1.0)
	
	/// The amount of overlap between consecutive analysis windows.
	///
	/// The system performs sound classification on a window-by-window basis. The system divides an
	/// audio stream into windows, and assigns labels and confidence values. This value determines how
	/// much two consecutive windows overlap. For example, 0.9 means that each window shares 90% of
	/// the audio that the previous window uses.
	var overlapFactor = Double(0.9)
	
	/// A list of sounds to identify from system audio input.
	var monitoredSounds: Set<SoundIdentifier> = [SoundIdentifier(labelName: Sound.bicycleBell.rawValue)]
	
	/// Retrieves a list of the sounds the system can identify.
	///
	/// - Returns: A set of identifiable sounds, including the associated labels that sound
	///   classification emits, and names suitable for displaying to the user.
	static func listAllValidSoundIdentifiers() throws -> Set<SoundIdentifier> {
		let labels = try SystemAudioClassifier.getAllPossibleLabels()
		return Set<SoundIdentifier>(labels.map {
			SoundIdentifier(labelName: $0)
		})
	}
	
	/// Retrieves a list of the sounds to identify
	///
	/// - Returns: A set of identifiable sounds, including the associated labels that sound
	///   classification emits, and names suitable for displaying to the user.
	static func listAllCustomSoundIdentifiers() throws -> Set<SoundIdentifier> {
		let labels: [String] = Sound.allCases.map( { $0.rawValue })
		let definedSounds = Set<SoundIdentifier>(labels.map {
			SoundIdentifier(labelName: $0)
		})
		return definedSounds.intersection(try listAllValidSoundIdentifiers())
	}
}

/// The runtime state of the app after setup.
class AppState: ObservableObject {
	/// A cancellable object for the lifetime of the sound classification.
	///
	/// While the app retains this cancellable object, a sound classification task continues to run until it
	/// terminates due to an error.
	private var detectionCancellable: AnyCancellable? = nil
	
	/// The configuration that governs sound classification.
	private var appConfig = AppConfiguration()
	
	/// A list of mappings between sounds and current detection states.
	///
	/// The app sorts this list to reflect the order in which the app displays them.
	@Published private var detectionStates: [DetectionStateTuple] = []
	
	@Published var detectedState: DetectionStateTuple?
	
	@Published var detectedSound: Sound?
	@Published var detectedConfidence: CGFloat = 0.0
	
	@Published var sensitivity: SensitivityLevel
	
	/// Indicates the state of sound classification .
	@Published var soundDetectionState: SoundDetectionState = .stopped
	
	/// Restarts detecting sounds according to the configuration you specify.
	/// - Parameter appConfig: A configuration that provides information for performing sound detection.

	init() {
		if let value = UserDefaults.standard.string(forKey: "sensitivityLevel"), let sensitivity = SensitivityLevel(rawValue: value) {
			self.sensitivity = sensitivity
		} else {
			self.sensitivity = .high
		}
	}

	func restartDetectionIfNeeded(appConfig: AppConfiguration) {
		if soundDetectionState == .running {
			stopDetection(appConfig: appConfig)
			startDetection(appConfig: appConfig)
		}
	}
	
	func pauseDetection(appConfig: AppConfiguration) {
		soundDetectionState = .paused
		SystemAudioClassifier.singleton.stopSoundClassification()
		detectionCancellable?.cancel()
	}

	func stopDetection(appConfig: AppConfiguration) {
		soundDetectionState = .stopped
		SystemAudioClassifier.singleton.stopSoundClassification()
		detectionCancellable?.cancel()
	}
	
	func startDetection(appConfig: AppConfiguration) {
		let classificationSubject = PassthroughSubject<SNClassificationResult, Error>()
		
		detectionCancellable =
		classificationSubject
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { _ in self.soundDetectionState = .stopped },
				  receiveValue: {
				self.detectionStates = AppState.advanceDetectionStates(self.detectionStates, givenClassificationResult: $0)
				self.findHighestDetectedState()
			})
		
		self.detectionStates =
		[SoundIdentifier](appConfig.monitoredSounds)
			.sorted(by: { $0.displayName < $1.displayName })
			.map { DetectionStateTuple(soundIdentifier: $0, detectionState: DetectionState(presenceThreshold: 0.5,
									   absenceThreshold: 0.3,
									   presenceMeasurementsToStartDetection: 2,
									   absenceMeasurementsToEndDetection: 30))
			}
		self.findHighestDetectedState()
		
		soundDetectionState = .running
		self.appConfig = appConfig
		SystemAudioClassifier.singleton.startSoundClassification(
			subject: classificationSubject,
			inferenceWindowSize: appConfig.inferenceWindowSize,
			overlapFactor: appConfig.overlapFactor)
	}
	
	/// Updates the detection states according to the latest classification result.
	///
	/// - Parameters:
	///   - oldStates: The previous detection states to update with a new observation from an ongoing
	///   sound classification.
	///   - result: The latest observation the app emits from an ongoing sound classification.
	///
	/// - Returns: A new array of sounds with their updated detection states.
	static func advanceDetectionStates(_ oldStates: [DetectionStateTuple],
									   givenClassificationResult result: SNClassificationResult) -> [DetectionStateTuple] {
		let confidenceForLabel = { (sound: SoundIdentifier) -> Double in
			let confidence: Double
			let label = sound.labelName
			if let classification = result.classification(forIdentifier: label) {
				confidence = classification.confidence
			} else {
				confidence = 0
			}
			return confidence
		}
		return oldStates.map { tuple in
			DetectionStateTuple(soundIdentifier: tuple.soundIdentifier, detectionState: DetectionState(advancedFrom: tuple.detectionState, currentConfidence: confidenceForLabel(tuple.soundIdentifier)))
		}
	}
	
	private func findHighestDetectedState() {
		detectedState = detectionStates.filter( { $0.detectionState.isDetected })
			.max(by: { $0.detectionState.currentConfidence > $1.detectionState.currentConfidence })
		if let detectedState = detectedState {
			if detectedState.detectionState.currentConfidence > sensitivity.detectedValue {
				detectedSound = detectedState.soundIdentifier.type
			}

			if detectedSound != nil {
				detectedConfidence = detectedState.detectionState.currentConfidence
			}
		} else {
			detectedSound = nil
			detectedConfidence = 0.0
		}
	}
}


class DetectionStateTuple: ObservableObject {
	
	@Published var soundIdentifier: SoundIdentifier
	@Published var detectionState: DetectionState
	
	init(soundIdentifier: SoundIdentifier, detectionState: DetectionState) {
		self.soundIdentifier = soundIdentifier
		self.detectionState = detectionState
	}
}
extension DetectionStateTuple: Equatable {
	static func == (lhs: DetectionStateTuple, rhs: DetectionStateTuple) -> Bool {
		return lhs.soundIdentifier == rhs.soundIdentifier
	}
}
