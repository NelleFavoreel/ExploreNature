//
//  AcountPage.swift
//  Eindopdracht
//
//  Created by Nelle Favoreel on 11/04/2024.
//

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
                            .foregroundColor(Color.green)
                            .frame(width: 100, height: 100)
                            .padding()
                    }
                    .sheet(isPresented: $isShowingImagePicker) {
                        ImagePicker(image: $profileImage)
                    }
                }

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
                                .foregroundColor(.green)
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
                }
                .padding()

                if let lastUpdatedDate = lastUpdatedDate {
                    Text("Data laatst bijgewerkt: \(formattedLastUpdatedDate(date: lastUpdatedDate))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding()
                }

                Spacer()
            }
            .navigationTitle("Account")
        }
    }

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
