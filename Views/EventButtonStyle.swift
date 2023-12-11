//
//  EventButtonStyle.swift
//  Lab Data Management
//
//  Created by William Thompson on 11/30/23.
//

import Foundation
import SwiftUI

struct EventButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
