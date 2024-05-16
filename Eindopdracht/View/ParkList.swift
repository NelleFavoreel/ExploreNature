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
                    HStack {
                        // Placeholder voor een afbeelding
                        Image(systemName: "tree.fill")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.green)
                            .padding(.trailing, 10)
                        
                        VStack(alignment: .leading) {
                            Text(park.name)
                                .font(.title3)
                                .foregroundColor(.primary)
                            Text(park.city_name)
                                .font(.callout)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Parken in België")
            .onAppear {
                viewModel.fetchPosts()
            }
        }
    }
}


#Preview {
    ParkList()
}
