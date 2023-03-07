//
//  DetectingSoundView.swift
//  safeRide Watch App
//
//  Created by Alexander Boswell on 2/22/23.
//

import Combine
import SwiftUI

struct DetectingSoundView: View {
	@ObservedObject var appState: AppState

    var body: some View {
		VStack {
			ZStack {
				icon
					.renderingMode(.template)
					.resizable()
					.frame(width: 60, height: 60)
					.foregroundColor(appState.soundDetectionState == .running ? detectedColor : nonDetectedColor)
				GeometryReader { proxy in
					Arc(size: proxy.size,
						radius: 50,
						startAngle: .degrees(45),
						endAngle: .degrees(-45))
					.foregroundColor(appState.detectedConfidence > 0.2 ? detectedColor : nonDetectedColor)
					Arc(size: proxy.size,
						radius: 50,
						startAngle: .degrees(225),
						endAngle: .degrees(135))
					.foregroundColor(appState.detectedConfidence > 0.2 ? detectedColor : nonDetectedColor)
					Arc(size: proxy.size,
						radius: 60,
						startAngle: .degrees(45),
						endAngle: .degrees(-45))
					.foregroundColor(appState.detectedConfidence > 0.4 ? detectedColor : nonDetectedColor)
					Arc(size: proxy.size,
						radius: 60,
						startAngle: .degrees(225),
						endAngle: .degrees(135))
					.foregroundColor(appState.detectedConfidence > 0.4 ? detectedColor : nonDetectedColor)
					Arc(size: proxy.size,
						radius: 70,
						startAngle: .degrees(45),
						endAngle: .degrees(-45))
					.foregroundColor(appState.detectedConfidence > 0.6 ? detectedColor : nonDetectedColor)
					Arc(size: proxy.size,
						radius: 70,
						startAngle: .degrees(225),
						endAngle: .degrees(135))
					.foregroundColor(appState.detectedConfidence > 0.6 ? detectedColor : nonDetectedColor)
					Arc(size: proxy.size,
						radius: 80,
						startAngle: .degrees(45),
						endAngle: .degrees(-45))
					.foregroundColor(appState.detectedConfidence > 0.8 ? detectedColor : nonDetectedColor)
					Arc(size: proxy.size,
						radius: 80,
						startAngle: .degrees(225),
						endAngle: .degrees(135))
					.foregroundColor(appState.detectedConfidence > 0.8 ? detectedColor : nonDetectedColor)
				}
				.animation(.easeInOut(duration: 0.1), value: appState.detectedConfidence)
			}

			Text(label)
				.font(.headline)
				
		}
		.onChange(of: appState.detectedConfidence) { _ in
			if appState.detectedConfidence > appState.sensitivity.detectedValue {
				playHaptics()
			}
		}
		
    }
	
	private func playHaptics() {
		WKInterfaceDevice().play(.notification)
	}

	private var icon: Image {
		if appState.soundDetectionState == .running {
			if let detectedSound = appState.detectedSound {
				return detectedSound.icon
			} else {
				return Image("ear")
			}
		}
		return Image("eardeaf")
	}

	private var label: String {
		if appState.soundDetectionState == .running {
			if let detectedSound = appState.detectedSound {
				return detectedSound.displayName
			} else {
				return "Listening..."
			}
		}
		return "Paused"
	}

	private let detectedColor: Color = .white
	private let nonDetectedColor: Color = .gray.opacity(0.2)
}

fileprivate struct Arc : Shape {
	var size: CGSize
	var radius: CGFloat
	var startAngle: Angle
	var endAngle: Angle

	func path(in rect: CGRect) -> Path {
		var p = Path()

		p.addArc(center: CGPoint(x: size.width/2 , y: size.height/2), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
		return p.strokedPath(.init(lineWidth: 3))
	}
}

struct DetectingSoundView_Previews: PreviewProvider {
    static var previews: some View {
		DetectingSoundView(appState: AppState())
    }
}
