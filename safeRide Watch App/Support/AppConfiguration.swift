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
