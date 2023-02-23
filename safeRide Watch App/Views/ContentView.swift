//
//  ContentView.swift
//  safeRide Watch App
//
//  Created by Alexander Boswell on 2/18/23.
//

import SwiftUI

struct ContentView: View {
	
	/// A configuration for managing the characteristics of a sound classification task.
	@State var appConfig = AppConfiguration()
	
	/// The runtime state that contains information about the strength of the detected sounds.
	@StateObject var appState = AppState()
	
	@State private var selectedTab = 1
	
    var body: some View {
		TabView(selection: $selectedTab) {
			if !(appState.soundDetectionState == .stopped) {
				ActionsView(appState: appState, appConfig: $appConfig)
					.tag(0)
			} else {
				SettingsView(appState: appState, appConfig: $appConfig)
					.tag(0)
			}
			ActivityView(state: appState, config: $appConfig)
				.tag(1)

		}
		.onChange(of: appState.soundDetectionState) { newValue in
			if newValue == .stopped {
				selectedTab = 1
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
