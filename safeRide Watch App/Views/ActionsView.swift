//
//  SettingsView.swift
//  safeRide Watch App
//
//  Created by Alexander Boswell on 2/18/23.
//

import SwiftUI

struct ActionsView: View {
    var body: some View {
		Grid {
			GridRow {
				ActionView(icon: Image("route"), backgroundColor: .blue, title: "Finish")
				Spacer()
				ActionView(icon: Image("pause"), backgroundColor: .blue, title: "Pause")
			}
			Spacer()
			GridRow  {
				ActionView(icon: Image("raindrops"), backgroundColor: .blue, title: "Lock")
				Spacer()
				ActionView(icon: Image("gear"), backgroundColor: .blue, title: "Settings")
			}
		}
    }
}

struct ActionView: View {
	var icon: Image
	var backgroundColor: Color
	var title: String
	
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
			
		}
		.buttonStyle(PlainButtonStyle())
		.accessibilityLabel(title)
	}
}

struct ActionsView_Previews: PreviewProvider {
    static var previews: some View {
        ActionsView()
    }
}
