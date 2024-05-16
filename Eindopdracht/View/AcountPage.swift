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
                // Profielfoto
                if let image = profileImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .padding(.top, 20)
                } else {
                    Button(action: {
                        isShowingImagePicker = true
                    }) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.green)
                            .frame(width: 120, height: 120)
                            .padding(.top, 20)
                    }
                    .sheet(isPresented: $isShowingImagePicker) {
                        ImagePicker(image: $profileImage)
                    }
                }

                Text(displayedName)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .padding(.top, 10)

                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Gegevens")
                            .font(.headline)
                            .fontWeight(.bold)

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

                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Naam:")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                            Text(name)
                                .font(.subheadline)
                        }

                        HStack {
                            Text("Achternaam:")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                            Text(lastName)
                                .font(.subheadline)
                        }

                        HStack {
                            Text("Woonplaats:")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                            Text(city)
                                .font(.subheadline)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                .padding()

                if let lastUpdatedDate = lastUpdatedDate {
                    Text("Data laatst bijgewerkt: \(formattedLastUpdatedDate(date: lastUpdatedDate))")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                }

                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
            .navigationBarTitle("Account", displayMode: .inline)
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
