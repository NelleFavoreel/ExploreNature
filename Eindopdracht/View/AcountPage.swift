//
//  AcountPage.swift
//  Eindopdracht
//
//  Created by Nelle Favoreel on 11/04/2024.
//

import Foundation


import SwiftUI

struct AccountPage: View {
    @State private var name = "John"
    @State private var lastName = "Doe"
    @State private var city = "New York"
    @State private var isEditing = false
    @State private var displayedName = "John Doe"
    @State private var displayedCity = "New York"
    @State private var profileImage: UIImage? = nil
    @State private var isShowingImagePicker = false
    var lastUpdatedDate: Date?
    
    var body: some View {
        NavigationView {
            VStack {
                // Profielfoto
                if let image = profileImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding()
                } else {
                    Button(action: {
                        isShowingImagePicker = true
                    }) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .padding()
                    }
                    .sheet(isPresented: $isShowingImagePicker) {
                        ImagePicker(image: $profileImage)
                    }
                }
                // Gegevens
                Text(displayedName)
                    .font(.largeTitle)
                    .padding()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Gegevens")
                            .font(.title)
                        
                        Spacer()
                        
                        NavigationLink(destination: EditAccountView(name: $name, lastName: $lastName, city: $city, onSave: {
                            displayedName = "\(name) \(lastName)"
                            displayedCity = city
                            isEditing = false
                        })) {
                            Image(systemName: "pencil")
                                .foregroundColor(.blue)
                        }
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Naam")
                            Text("Achternaam")
                            Text("Woonplaats")
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text(name)
                            Text(lastName)
                            Text(city)
                        }
                    }
                    HStack{
                        Text("Favorieten:")
                            .font(.title)
                    }
                    .padding(.top, 20)
                }
                .padding()
                if let lastUpdatedDate = lastUpdatedDate {
                    Text("Laatst bijgewerkt: \(formattedLastUpdatedDate(date: lastUpdatedDate))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding()
                }
                Spacer()
            }
            .navigationTitle("Account")
        }
    }
    // Methode om de datum op een geschikte manier weer te geven
    private func formattedLastUpdatedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    AccountPage()
}
