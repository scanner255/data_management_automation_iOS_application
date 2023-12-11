//
//  startView.swift
//  Lab Data Management
//
//  Created by William Thompson on 11/19/23.
//

import SwiftUI

struct StartView: View {
    @Binding var dataCollectionFlag: Bool

    var body: some View {
        VStack {
            Spacer()
            
            Image("company_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(100)
            
            Text("Company device name\nDevice Logger")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button(action: {
                enterPreliminaryData()
            }) {
                Text("Enter Preliminary Data")
                    .font(.system(size: 35))
                    .frame(width: 500, height: 100, alignment: .center)
            }
            .background(Color.gray)
            .foregroundColor(Color.white)
            .cornerRadius(5)
            .padding()
            
            Button(action: {
                startDataCollection()
            }) {
                Text("Start Logging")
                    .font(.system(size: 35))
                    .frame(width: 500, height: 100, alignment: .center)
            }
            .background(Color.green)
            .foregroundColor(Color.white)
            .cornerRadius(5)
        }
    }

    func startDataCollection() {
        dataCollectionFlag = false
    }
    
    func enterPreliminaryData() {
        
    }
}
