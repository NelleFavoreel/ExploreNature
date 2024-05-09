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
    @State private var selectionTab = 1
    @State private var isWiFiConnected = true // State variabele voor wifi-verbinding
    @State private var previousWiFiStatus = true // Vorige wifi-status om verandering te detecteren
    @State private var showingAlert = false // State variabele om de alert weer te geven
    @State private var lastUpdatedDate: Date? // State variabele voor de laatst bijgewerkte datum
    
    var body: some View {
        TabView(selection: $selectionTab){
            MapView().tabItem {
                Label("Map", systemImage: "map")
            }.tag(1)
            
            ParkList().tabItem {
                Label("List", systemImage: "list.bullet")
            }.tag(2)
            
            AccountPage(lastUpdatedDate: lastUpdatedDate).tabItem { // Doorgeven van de laatst bijgewerkte datum aan de AccountPage
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
            // Start met het controleren van de netwerkstatus
            checkNetworkStatus()
        }
    }
    
    // Methode om de netwerkstatus te controleren
    private func checkNetworkStatus() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                isWiFiConnected = path.status == .satisfied
                
                // Controleer of de wifi-verbinding is verbroken en toon dan de pop-upmelding
                if !isWiFiConnected && previousWiFiStatus {
                    showingAlert = true
                }
                
                // Als de wifi-verbinding wordt hersteld, werk de gegevens bij en sla de datum op
                if isWiFiConnected && !previousWiFiStatus {
                    fetchPostsAndUpdateData()
                }
                
                previousWiFiStatus = isWiFiConnected
            }
        }
    }
    
    // Methode om gegevens op te halen en bij te werken
    private func fetchPostsAndUpdateData() {
        // Voer de logica uit om gegevens op te halen en bij te werken
        // Bijvoorbeeld met behulp van de ViewModel
        let viewModel = ViewModel() // Maak een instantie van de ViewModel
        viewModel.fetchPosts() // Roep de methode aan om gegevens op te halen
        
        // Update de laatst bijgewerkte datum naar de huidige datum en tijd
        lastUpdatedDate = Date()
        
        // Sla de laatst bijgewerkte datum op in UserDefaults
        UserDefaults.standard.set(lastUpdatedDate, forKey: "lastUpdatedDate")
    }
}




#Preview {
    ContentView()
}
