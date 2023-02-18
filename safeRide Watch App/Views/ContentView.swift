//
//  ContentView.swift
//  safeRide Watch App
//
//  Created by Alexander Boswell on 2/18/23.
//

import SwiftUI

struct ContentView: View {
	
	@State private var selectedTab = 1
	
    var body: some View {
		TabView(selection: $selectedTab) {
			SettingsView()
				.tag(0)
			ActivityView()
				.tag(1)
			ActionsView()
				.tag(2)
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
