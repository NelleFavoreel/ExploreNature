//
//  MapView.swift
//  Eindopdracht
//
//  Created by Nelle Favoreel on 29/03/2024.
//



import SwiftUI
import MapKit
 
struct MapView: View {
    @StateObject var viewModel = ViewModel()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.8503, longitude: 4.3517), span: MKCoordinateSpan(latitudeDelta: 3.0, longitudeDelta: 3.0))
    @State private var userTrackingMode: MapUserTrackingMode = .follow

    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: viewModel.posts) { park in
            MapPin(coordinate: CLLocationCoordinate2D(latitude: Double(park.lat) ?? 0, longitude: Double(park.long) ?? 0), tint: .red)
        }
        .padding(.top, -100.0)
        .onAppear {
            viewModel.fetchPosts()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}




#Preview {
    MapView()
}
