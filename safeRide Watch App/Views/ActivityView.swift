//
//  ActivityView.swift
//  safeRide Watch App
//
//  Created by Alexander Boswell on 2/18/23.
//

import SwiftUI

struct ActivityView: View {
    var body: some View {
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
//		.border(Color.white)
		.onTapGesture {
			
		}
		.buttonStyle(PlainButtonStyle())
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
