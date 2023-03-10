//
//  SettingsView.swift
//  safeRide Watch App
//
//  Created by Alexander Boswell on 2/18/23.
//

import SwiftUI

struct ActionsView: View {
	@ObservedObject var appState: AppState
	@Binding var appConfig: AppConfiguration
	
	@State private var showSettingsView = false

    var body: some View {
		Grid {
			GridRow {
				ActionView(icon: Image("route"),foregroundColor: .white, backgroundColor: Color("DarkAccentColor"), title: "Finish") {
					appState.stopDetection(appConfig: appConfig)
					WKInterfaceDevice().play(.stop)
				}
				Spacer()
				if appState.soundDetectionState == .running {
					ActionView(icon: Image("pause"), foregroundColor: .white, backgroundColor: Color("DarkAccentColor"), title: "Pause") {
						appState.pauseDetection(appConfig: appConfig)
						WKInterfaceDevice().play(.click)
					}
				} else if appState.soundDetectionState == .paused {
					ActionView(icon: Image("play"), foregroundColor: .white, backgroundColor: Color("DarkAccentColor"), title: "Resume") {
						appState.startDetection(appConfig: appConfig)
						WKInterfaceDevice().play(.start)
					}
				}
			}
			Spacer()
			GridRow {
				ActionView(icon: Image("gear"), foregroundColor: Color("GrayColor"), backgroundColor: .white, title: "Settings") {
					showSettingsView = true
					WKInterfaceDevice().play(.click)

				}
				Spacer()
			}
		}
		.sheet(isPresented: $showSettingsView) {
			SettingsView(appState: appState, appConfig: $appConfig)
		}
    }
}

struct ActionView: View {
	var icon: Image
	var foregroundColor: Color
	var backgroundColor: Color
	var title: String
	var action: () -> Void
	
	var body: some View {
		VStack {
			ZStack {
				Circle()
					.foregroundColor(backgroundColor)
				icon
					.renderingMode(.template)
					.resizable()
					.foregroundColor(foregroundColor)
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

struct ActionsView_Previews: PreviewProvider {
    static var previews: some View {
		ActionsView(appState: AppState(), appConfig: .constant(AppConfiguration()))
    }
}
