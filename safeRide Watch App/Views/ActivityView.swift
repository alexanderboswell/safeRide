//
//  ActivityView.swift
//  safeRide Watch App
//
//  Created by Alexander Boswell on 2/18/23.
//

import SwiftUI

struct ActivityView: View {
	@ObservedObject var appState: AppState
	@Binding var appConfig: AppConfiguration

    var body: some View {
		ZStack {
			switch appState.soundDetectionState {
				case .stopped:
					ZStack {
						Circle()
							.foregroundColor(.accentColor)
						VStack {
							Image("bicycle")
								.resizable()
								.renderingMode(.template)
								.tint(.white)
								.frame(width: 90, height: 90)
							Text("Start")
								.font(.headline)
						}
					}
					.onTapGesture {
						appState.restartDetection(appConfig: appConfig)
					}
					.buttonStyle(PlainButtonStyle())
				case .paused, .running:
					DetectingSoundView(appState: appState)
			}
		}
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
		ActivityView(appState: AppState(), appConfig: .constant(AppConfiguration()))
    }
}
