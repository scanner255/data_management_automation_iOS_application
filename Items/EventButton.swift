//
//  EventButton.swift
//  Lab Data Management
//
//  Created by William Thompson on 11/19/23.
//

import SwiftUI

struct EventButton : View {
    @State private var isTapped:Bool = false
    let event: String
    let logEvent: (String) -> Void
    
    var body: some View {
        Button(event, action: {
            self.isTapped = true
            self.logEvent(self.event)
            print(event + " button clicked")
            // Perform your action here

            // Simulate a brief color change
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    self.isTapped = false
                }
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(self.isTapped ? Color.cyan : Color.blue) // Change color conditionally
        .foregroundColor(Color.white)
        .cornerRadius(5)
        .controlSize(/*@START_MENU_TOKEN@*/.regular/*@END_MENU_TOKEN@*/)
    }
    
}
