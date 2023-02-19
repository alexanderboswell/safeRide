//
//  SettingsView.swift
//  safeRide Watch App
//
//  Created by Alexander Boswell on 2/18/23.
//

import SwiftUI

struct SettingsView: View {
	/// Indicates whether to display the setup workflow.
	@State var showSetup = true
	
	/// A configuration for managing the characteristics of a sound classification task.
	@State var appConfig = AppConfiguration()
	
	/// The runtime state that contains information about the strength of the detected sounds.
	@StateObject var appState = AppState()
	
//	var body: some View {
//		ZStack {
//			if showSetup {
//				SetupMonitoredSoundsView(
//					querySoundOptions: { return try AppConfiguration.listAllSoundIdentifiers() },
//					selectedSounds: $appConfig.monitoredSounds,
//					doneAction: {
//						showSetup = false
//						appState.restartDetection(config: appConfig)
//					})
//			} else {
//				DetectSoundsView(state: appState,
//								 config: $appConfig,
//								 configureAction: { showSetup = true })
//			}
//		}
//	}
    var body: some View {
		List {
			Section("Personalization") {
				Button {
					
				} label: {
					HStack {
						Image("bell")
							.resizable()
							.renderingMode(.template)
							.tint(.white)
							.frame(width: 32, height: 32)
						Text("Add my bicycle bell")
							.padding(.leading, 10)
					}
				}
			}
			Section("Listen for...") {
				ClassifierListView(
					querySoundOptions: { return try AppConfiguration.listAllSoundIdentifiers() },
					selectedSounds: $appConfig.monitoredSounds,
					doneAction: {
						showSetup = false
						appState.restartDetection(config: appConfig)
					})
			}
			Section("Licenses") {
				
			}
		}
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
