//
//  MapView.swift
//  Eindopdracht
//
//  Created by Nelle Favoreel on 29/03/2024.
//



import SwiftUI
import MapKit
 
let locationManager = CLLocationManager()

struct MapView: View {
    @StateObject var viewModel = ViewModel()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.8503, longitude: 4.3517), span: MKCoordinateSpan(latitudeDelta: 3.0, longitudeDelta: 3.0))
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var selectedPark: ParkInfo?

    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: viewModel.posts) { park in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(park.lat) ?? 0, longitude: Double(park.long) ?? 0)) {
                    Image(systemName: "tree.fill")
                        .resizable()
                        .foregroundColor(Color.green)
                        .frame(width: 30, height: 30)
                        .onTapGesture {
                            self.selectedPark = park // Gebruik `self` voor `selectedPark`
                        }
                }
                
            }
            .padding(.top, -200.0)
            
            
            .edgesIgnoringSafeArea(.all)
            .frame(height: 700.0)
            .onAppear {
                viewModel.fetchPosts()
                locationManager.requestWhenInUseAuthorization()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            if let park = selectedPark {
                VStack {
                    HStack {
                        Button(action: {
                            self.selectedPark = nil // Gebruik `self` voor `selectedPark`
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red)
                                .padding()
                        }
                        VStack(alignment: .leading) {
                            Text(park.name)
                                .font(.headline)
                            Text(park.city_name)
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                        }
                        .frame(width: 250.0)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
                }
                .onTapGesture {
                    self.selectedPark = nil // Gebruik `self` voor `selectedPark`
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
}



#Preview {
    MapView()
}
