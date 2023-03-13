//
//  HistoryView.swift
//  safeRide Watch App
//
//  Created by Alexander Boswell on 3/10/23.
//

import SwiftUI

struct HistoryView: View {
	@ObservedObject var appState: AppState

    var body: some View {
		List {
			Section("History") {
				ForEach(appState.detectedSoundHistory.reversed(), id: \.date) { historyData in
					HStack {
						historyData.sound.icon
							.renderingMode(.template)
							.resizable()
							.frame(width: 35, height: 35)
						VStack(alignment: .leading) {
							Text(historyData.sound.displayName)
							Text(historyData.date, format: .dateTime.hour().minute())
						}
						.padding()
					}
				}
			}
		}
    }
}
