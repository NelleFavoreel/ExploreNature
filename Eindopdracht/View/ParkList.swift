//
//  ParkList.swift
//  Eindopdracht
//
//  Created by Nelle Favoreel on 04/04/2024.
//


import SwiftUI



struct ParkList: View {
    @StateObject var viewModel = ParkInfoViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.posts) { park in
                NavigationLink(destination: ParkDetail(park: park)) {
                    VStack(alignment: .leading) {
                        Text(park.name)
                            .font(.title3)
                            .foregroundColor(Color.green)
                        Text(park.city_name)
                            .font(.callout)
                    }
                }
            }
            .navigationTitle("Parken lijst")
            .onAppear {
                viewModel.fetchPosts()
            }
        }
    }
}

#Preview {
    ParkList()
}
