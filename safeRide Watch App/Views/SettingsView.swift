//
//  SettingsView.swift
//  safeRide Watch App
//
//  Created by Alexander Boswell on 2/18/23.
//

import SwiftUI

struct SettingsView: View {
	@ObservedObject var appState: AppState
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
			}
			Section("Listen for...") {
				ClassifierListView(
					querySoundOptions: { return try AppConfiguration.listAllCustomSoundIdentifiers() },
					selectedSounds: $appConfig.monitoredSounds,
					doneAction: {
						appState.restartDetection(appConfig: appConfig)
					})
			}
			Section("Licenses") {
				
			}
		}
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
		SettingsView(appState: AppState(), appConfig: .constant(AppConfiguration()))
    }
}
