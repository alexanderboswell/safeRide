//
//  AppConfiguration.swift
//  safeRide Watch App
//
//  Created by Alexander Boswell on 2/18/23.
//
import Combine
import SoundAnalysis
import SwiftUI

enum SoundDetectionState {
	case running
	case paused
	case stopped
}

enum Sound: String, CaseIterable {
	case bicycle = "bicycle"
	case bicycleBell = "bicycle_bell"
	case bus = "bus"
	case carHorn = "car_horn"
	case carPassingBy = "car_passing_by"
	case emergencyVehicle = "emergency_vehicle"
	case motorcycle = "motorcycle"
	case policeSiren = "police_siren"
	case speech = "speech"
	case yell = "yell"
	
	var icon: Image {
		switch self {
			case .bicycle:
				return Image("bicycle")
			case .bicycleBell:
				return Image("bell")
			case .bus:
				return Image("bus")
			case .carHorn:
				return Image("car")
			case .carPassingBy:
				return Image("carPassingBy")
			case .emergencyVehicle:
				return Image("emergencyVehicle")
			case .motorcycle:
				return Image("motorcycle")
			case .policeSiren:
				return Image("policeSiren")
			case .speech:
				return Image("speech")
			case .yell:
				return Image("yell")
		}
	}
	
	var displayName: String {
		switch self {
			case .bicycle:
				return "Bicycle"
			case .bicycleBell:
				return "Bicycle Bell"
			case .bus:
				return "Bus"
			case .carHorn:
				return "Car Horn"
			case .carPassingBy:
				return "Car Passing By"
			case .emergencyVehicle:
				return "Emergency Vehicle"
			case .motorcycle:
				return "Motorcycle"
			case .policeSiren:
				return "Police Siren"
			case .speech:
				return "Speech"
			case .yell:
				return "Yell"
		}
	}
}


/// Contains customizable settings that control app behavior.
struct AppConfiguration {
	/// Indicates the amount of audio, in seconds, that informs a prediction.
	var inferenceWindowSize = Double(1.5)
	
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
///
/// Sound classification begins after completing the setup process. The `DetectSoundsView` displays
/// the results of the classification. Instances of this class contain the detection information that
/// `DetectSoundsView` renders. It incorporates new classification results as the app produces them into
/// the cumulative understanding of what sounds are currently present. It tracks interruptions, and allows for
/// restarting an analysis by providing a new configuration.
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
	
	/// Indicates whether a sound classification is active.
	///
	/// When `false,` the sound classification has ended for some reason. This could be due to an error
	/// emitted from Sound Analysis, or due to an interruption in the recorded audio. The app needs to prompt
	/// the user to restart classification when `false.`
	@Published var soundDetectionState: SoundDetectionState = .stopped
	
	/// Begins detecting sounds according to the configuration you specify.
	///
	/// If the sound classification is running when calling this method, it stops before starting again.
	///
	/// - Parameter config: A configuration that provides information for performing sound detection.
	func restartDetection(config: AppConfiguration) {
		stopDetection(config: config)
		startDetection(config: config)
	}
	
	func pauseDetection(config: AppConfiguration) {
		soundDetectionState = .paused
		SystemAudioClassifier.singleton.stopSoundClassification()
		detectionCancellable?.cancel()
	}

	func stopDetection(config: AppConfiguration) {
		soundDetectionState = .stopped
		SystemAudioClassifier.singleton.stopSoundClassification()
		detectionCancellable?.cancel()
	}
	
	func startDetection(config: AppConfiguration) {
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
		[SoundIdentifier](config.monitoredSounds)
			.sorted(by: { $0.displayName < $1.displayName })
			.map { DetectionStateTuple(soundIdentifier: $0, detectionState: DetectionState(presenceThreshold: 0.5,
									   absenceThreshold: 0.3,
									   presenceMeasurementsToStartDetection: 2,
									   absenceMeasurementsToEndDetection: 30))
			}
		self.findHighestDetectedState()
		
		soundDetectionState = .running
		appConfig = config
		SystemAudioClassifier.singleton.startSoundClassification(
			subject: classificationSubject,
			inferenceWindowSize: config.inferenceWindowSize,
			overlapFactor: config.overlapFactor)
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
			detectedSound = detectedState.soundIdentifier.type
			detectedConfidence = detectedState.detectionState.currentConfidence
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


//extension (SoundIdentifier, DetectionState) : Equatable {
//	static func == (lhs: (SoundIdentifier, DetectionState), rhs: (SoundIdentifier, DetectionState)) -> Bool {
//		return lhs.0 == rhs.0 && lhs.1 == rhs.1
//	}
//}
