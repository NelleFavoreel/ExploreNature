//
//  WelcomeView.swift
//  Eindopdracht
//
//  Created by Nelle Favoreel on 10/05/2024.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    var onDiscover: () -> Void // Closure toegevoegd om te worden aangeroepen wanneer de gebruiker op de knop klikt

    var body: some View {
        VStack {
            Text("Welkom bij de app!")
                .font(.title)
                .padding()
            Text("Dit is een geweldige app waar je alles kunt vinden wat je nodig hebt.")
                .multilineTextAlignment(.center)
                .padding()
            Button(action: {
                // Roep de closure aan wanneer de gebruiker op de knop klikt
                onDiscover()
            }) {
                Text("Ontdek de app")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}
