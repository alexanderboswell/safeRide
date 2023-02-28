//
//  SettingsView.swift
//  safeRide Watch App
//
//  Created by Alexander Boswell on 2/18/23.
//

import SwiftUI

struct StepperView: View {
	@State private var value = 0
	let colors: [Color] = [.orange, .red, .gray, .blue,
						   .green, .purple, .pink]
	
	func incrementStep() {
		value += 1
		if value >= colors.count { value = 0 }
	}
	
	func decrementStep() {
		value -= 1
		if value < 0 { value = colors.count - 1 }
	}
	
	var body: some View {
		Stepper {
			Text("25%")
				.font(.body)
		} onIncrement: {
			incrementStep()
		} onDecrement: {
			decrementStep()
		}
		.padding(5)
		.background(colors[value])
	}
}

struct SettingsView: View {
//	/// Indicates whether to display the setup workflow.
//	@State var showSetup = true
	
	/// The runtime state that contains information about the strength of the detected sounds.
	@ObservedObject var appState: AppState
	
	/// The configuration that dictates aspects of sound classification, as well as aspects of the visualization.
	@Binding var appConfig: AppConfiguration
	
	@State var sensitivity: String = "High"
	var sensitivies = ["Low", "Medium", "High"]
	
    var body: some View {
		List {
			Section("Personalization") {
//				Button {
//
//				} label: {
//					HStack {
//						Image("bell")
//							.resizable()
//							.renderingMode(.template)
//							.tint(.white)
//							.frame(width: 32, height: 32)
//						Text("Add my bicycle bell")
//							.padding(.leading, 10)
//					}
//				}
				
				Picker("Sensitivity", selection: $sensitivity) {
					ForEach(sensitivies, id: \.self) {
						Text($0)
					}
				}
//				VStack {
//					Text("Sensitivity")
//					Stepper {
//						Text("\(Int(appState.sensitivity * 100))%")
//							.font(.body)
//					} onIncrement: {
//						if appState.sensitivity < 1.0 {
//							appState.sensitivity += 0.25
//						}
//					} onDecrement: {
//						if appState.sensitivity > 0.25 {
//							appState.sensitivity -= 0.25
//						}
//					}
//					.accessibilityLabel("Sensitivity")
//				}
			}
			Section("Listen for...") {
				ClassifierListView(
					querySoundOptions: { return try AppConfiguration.listAllCustomSoundIdentifiers() },
					selectedSounds: $appConfig.monitoredSounds,
					doneAction: {
						appState.restartDetection(config: appConfig)
					})
			}
			Section("Licenses") {
				
			}
		}
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
