//
//  ContentView.swift
//  Eindopdracht
//
//  Created by Nelle Favoreel on 29/03/2024.
//
import SwiftUI
import MapKit
import Network

struct ContentView: View {
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true

    @State private var selectionTab = 1
    @State private var isWiFiConnected = true
    @State private var previousWiFiStatus = true
    @State private var showingAlert = false
    @State private var lastUpdatedDate: Date? 

    var body: some View {
        Group {
            if isFirstLaunch {
                WelcomeView {
                    isFirstLaunch = false
                }
            } else {
                
                TabView(selection: $selectionTab) {
                    MapView().tabItem {
                        Label("Map", systemImage: "map")
                    }.tag(1)

                    ParkList().tabItem {
                        Label("List", systemImage: "list.bullet")
                    }.tag(2)

                    AccountPage(lastUpdatedDate: lastUpdatedDate).tabItem {
                        Label("Account", systemImage: "person.crop.circle")
                    }.tag(3)
                }
                .accentColor(.blue)
                
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("Geen WiFi-verbinding"),
                        message: Text("Er is geen WiFi-verbinding beschikbaar."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .onAppear {
                    checkNetworkStatus()
                }
            }
        }
    }
    // chatgpt helpt for this
    private func checkNetworkStatus() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)

        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                isWiFiConnected = path.status == .satisfied

                if !isWiFiConnected && previousWiFiStatus {
                    showingAlert = true
                }

                if isWiFiConnected && !previousWiFiStatus {
                    fetchPostsAndUpdateData()
                }

                previousWiFiStatus = isWiFiConnected
            }
        }
    }

    private func fetchPostsAndUpdateData() {
        let viewModel = ViewModel()
        viewModel.fetchPosts()

        lastUpdatedDate = Date()
        UserDefaults.standard.set(lastUpdatedDate, forKey: "lastUpdatedDate")
    }
}


#Preview {
    ContentView()
}
