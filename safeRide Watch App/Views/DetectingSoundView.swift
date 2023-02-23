//
//  DetectingSoundView.swift
//  safeRide Watch App
//
//  Created by Alexander Boswell on 2/22/23.
//

import SwiftUI

struct DetectingSoundView: View {
	/// The runtime state that contains information about the strength of the detected sounds.
	@ObservedObject var state: AppState

	private let detectedColor: Color = .white
	private let nonDetectedColor: Color = .gray.opacity(0.2)

	@State var headlineText = "Listening..."
	@State var image = Image("ear")
	@State var imageColor = Color.white

    var body: some View {
		VStack {
			ZStack {
				image
					.renderingMode(.template)
					.resizable()
					.frame(width: 60, height: 60)
					.foregroundColor(imageColor)
				GeometryReader { proxy in
					Arc(centerX: proxy.size.width / 2,
						centerY: proxy.size.height / 2,
						radius: 50,
						startAngle: .degrees(45),
						endAngle: .degrees(-45))
					Arc(centerX: proxy.size.width / 2,
						centerY: proxy.size.height / 2,
						radius: 50,
						startAngle: .degrees(225),
						endAngle: .degrees(135))
					Arc(centerX: proxy.size.width / 2,
						centerY: proxy.size.height / 2,
						radius: 60,
						startAngle: .degrees(45),
						endAngle: .degrees(-45))
					Arc(centerX: proxy.size.width / 2,
						centerY: proxy.size.height / 2,
						radius: 60,
						startAngle: .degrees(225),
						endAngle: .degrees(135))
					Arc(centerX: proxy.size.width / 2,
						centerY: proxy.size.height / 2,
						radius: 70,
						startAngle: .degrees(45),
						endAngle: .degrees(-45))
					.foregroundColor(detectedColor)
					Arc(centerX: proxy.size.width / 2,
						centerY: proxy.size.height / 2,
						radius: 70,
						startAngle: .degrees(225),
						endAngle: .degrees(135))
					.foregroundColor(detectedColor)
					Arc(centerX: proxy.size.width / 2,
						centerY: proxy.size.height / 2,
						radius: 80,
						startAngle: .degrees(45),
						endAngle: .degrees(-45))
					.foregroundColor(nonDetectedColor)
					Arc(centerX: proxy.size.width / 2,
						centerY: proxy.size.height / 2,
						radius: 80,
						startAngle: .degrees(225),
						endAngle: .degrees(135))
					.foregroundColor(nonDetectedColor)
				}
			}
			Text(headlineText)
				.font(.headline)
		}
		.onChange(of: state.soundDetectionState) { newValue in
			switch newValue {
				case .running:
					headlineText = "Listening..."
					image = Image("ear")
					imageColor = detectedColor
				case .paused:
					headlineText = "Paused"
					image = Image("eardeaf")
					imageColor = nonDetectedColor
				case .stopped:
					break
			}
		}
    }
}

struct Arc : Shape {
	var centerX: CGFloat
	var centerY: CGFloat
	var radius: CGFloat
	var startAngle: Angle
	var endAngle: Angle

	func path(in rect: CGRect) -> Path {
		var p = Path()

		p.addArc(center: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
		return p.strokedPath(.init(lineWidth: 3))
	}
}

struct DetectingSoundView_Previews: PreviewProvider {
    static var previews: some View {
        DetectingSoundView(state:  AppState())
    }
}
