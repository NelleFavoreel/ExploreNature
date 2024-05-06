//
//  EditAccountView.swift
//  Eindopdracht
//
//  Created by Nelle Favoreel on 11/04/2024.
//

import Foundation
import SwiftUI

struct EditAccountView: View {
    @Binding var name: String
    @Binding var lastName: String
    @Binding var city: String
    let onSave: () -> Void // Closure om te worden aangeroepen wanneer op "Save" wordt gedrukt

    var body: some View {
        VStack {
            Text("Naam")
            TextField("Naam", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text("Achternaam")
            TextField("Achternaam", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text("Woonplaats")
            TextField("Woonplaats", text: $city)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Spacer()

            Button("Save") {
                // Roep de onSave-closure aan om wijzigingen op te slaan
                onSave()
            }
        }
        .padding()
    }
}

struct AccountPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage()
    }
}
