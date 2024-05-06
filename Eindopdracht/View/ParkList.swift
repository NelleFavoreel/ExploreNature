//
//  ParkList.swift
//  Eindopdracht
//
//  Created by Nelle Favoreel on 04/04/2024.
//


import SwiftUI

struct ParkList: View {
    @StateObject var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.posts) { park in
                NavigationLink(destination: ParkDetail(park: park)) {
                    VStack(alignment: .leading) {
                        Text(park.name)
                        Text(park.city_name)
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
