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

    var body: some View {
		List {
			Section("Listen for...") {
				ClassifierListView(
					appState: appState,
					appConfig: $appConfig,
					querySoundOptions: { return try AppConfiguration.listAllCustomSoundIdentifiers() },
					selectedSounds: $appConfig.monitoredSounds,
					doneAction: {
						appState.restartDetectionIfNeeded(appConfig: appConfig)
					})
			}
			Section("Personalization") {
				Picker("Sensitivity", selection: $appState.sensitivity) {
					ForEach(SensitivityLevel.allCases, id: \.self) {
						Text($0.rawValue)
					}
				}
				.onChange(of: appState.sensitivity) { newValue in
					UserDefaults.standard.set(newValue.rawValue, forKey: "sensitivityLevel")
				}

				Toggle("Animations", isOn: $appState.animationsEnabled)
					.onChange(of: appState.animationsEnabled) { newValue in
						UserDefaults.standard.set(newValue, forKey: "animationsEnabled")
					}
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
