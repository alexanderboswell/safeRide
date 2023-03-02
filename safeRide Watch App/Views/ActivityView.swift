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
					GeometryReader { proxy in
						ZStack {
							Image("background")
								.cornerRadius(proxy.size.width/2)
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
						.frame(maxWidth: .infinity, maxHeight: .infinity)
					}
					.onTapGesture {
						appState.startDetection(appConfig: appConfig)
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
