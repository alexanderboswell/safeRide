//
//  SettingsView.swift
//  safeRide Watch App
//
//  Created by Alexander Boswell on 2/18/23.
//

import SwiftUI
import WatchKit

struct ActionsView: View {
	/// The runtime state that contains information about the strength of the detected sounds.
	@ObservedObject var appState: AppState
	
	/// The configuration that dictates aspects of sound classification, as well as aspects of the visualization.
	@Binding var appConfig: AppConfiguration
	
    var body: some View {
		Grid {
			GridRow {
				ActionView(icon: Image("route"), backgroundColor: .blue, title: "Finish") {
					appState.stopDetection(config: appConfig)
				}
				Spacer()
				if appState.soundDetectionIsRunning {
					ActionView(icon: Image("pause"), backgroundColor: .blue, title: "Pause") {
						appState.stopDetection(config: appConfig)
					}
				} else {
					ActionView(icon: Image("play"), backgroundColor: .green, title: "Resume") {
						//						appState.restartDetection(config: appConfig)
						appState.startDetection(config: appConfig)
					}
				}
			}
			Spacer()
			GridRow {
//				ActionView(icon: Image("raindrops"), backgroundColor: .blue, title: "Lock") {
//					WKInterfaceDevice.current().enableWaterLock()
//				}
//				Spacer()
				ActionView(icon: Image("gear"), backgroundColor: .blue, title: "Settings") {
					
				}
				Spacer()
			}
		}
    }
}

struct ActionView: View {
	var icon: Image
	var backgroundColor: Color
	var title: String
	var action: () -> Void
	
	var body: some View {
		VStack {
			ZStack {
				Circle()
					.foregroundColor(backgroundColor)
				icon
					.resizable()
					.padding()
		
			}
			.frame(width: 48, height: 48)
			Text(title)
		}
		.onTapGesture {
			action()
		}
		.buttonStyle(PlainButtonStyle())
		.accessibilityLabel(title)
		.frame(width: 72)
	}
}

//struct ActionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActionsView()
//    }
//}
