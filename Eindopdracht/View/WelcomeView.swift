//
//  WelcomeView.swift
//  Eindopdracht
//
//  Created by Nelle Favoreel on 10/05/2024.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    var onDiscover: () -> Void

    var body: some View {
        Image("logo2")
        VStack {
            
            Text("Welkom bij NatureExplorer!")
                .font(.title)
                .padding()
            Text("In deze appp kan je verschillende leuke parken terug vinden voor mensen met een beperking.")
                .multilineTextAlignment(.center)
                .padding()
            Button(action: {
                onDiscover()
            }) {
                Text("Ontdek de app")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
    
}
#Preview{
    WelcomeView{
    }
}
