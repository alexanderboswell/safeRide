//
//  ActivityView.swift
//  safeRide Watch App
//
//  Created by Alexander Boswell on 2/18/23.
//

import SwiftUI

struct ActivityView: View {
	/// The runtime state that contains information about the strength of the detected sounds.
	@ObservedObject var state: AppState
	
	/// The configuration that dictates aspects of sound classification, as well as aspects of the visualization.
	@Binding var config: AppConfiguration

    var body: some View {
		ZStack {
			switch state.soundDetectionState {
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
						state.restartDetection(config: config)
					}
					.buttonStyle(PlainButtonStyle())
				case .paused, .running:
					ZStack {
						DetectingSoundView(state: state)
						List {
//							ForEach(state.detectionStates, id: \.0.labelName) {
//								if $0.1.isDetected {
//									Text($0.0.labelName)
//									Text("\($0.1.currentConfidence)")
//								}
								//					generateMeterCard(confidence: $0.1.isDetected ? $0.1.currentConfidence : 0.0,
								//									  label: $0.0.displayName)
//							}
						}
					}
			}
		}
    }
}

//struct ActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityView()
//    }
//}
