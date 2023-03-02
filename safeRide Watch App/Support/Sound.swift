//
//  Sound.swift
//  safeRide Watch App
//
//  Created by Alexander Boswell on 3/1/23.
//

import SwiftUI

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
			case .speech, .yell:
				return Image("voice")
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
