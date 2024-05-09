//
//  ContentView.swift
//  Eindopdracht
//
//  Created by Nelle Favoreel on 29/03/2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var selectionTab = 1

    var body: some View {
        TabView(selection: $selectionTab){
            MapView().tabItem {
                Label("Map", systemImage: "map")
            }.tag(1)
            
            ParkList().tabItem {
                Label("List", systemImage: "list.bullet")
            }.tag(2)
            
            AccountPage().tabItem {
                Label("Account", systemImage: "person.crop.circle")
            }.tag(3)
        }
        .accentColor(.blue)
        .background(Color.red)
    }
}


#Preview {
    ContentView()
}
