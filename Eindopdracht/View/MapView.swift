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
    @State private var selectedPark: ParkInfo?

    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: viewModel.posts) { park in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(park.lat) ?? 0, longitude: Double(park.long) ?? 0)) {
                    Image(systemName: "tree.fill")                        .resizable()
                        .foregroundColor(Color.green)
                        .frame(width: 30, height: 30)
                        .onTapGesture {
                            selectedPark = park
                        }
                }
            }
            .padding(.top, -100.0)
            .onAppear {
                viewModel.fetchPosts()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            if let park = selectedPark {
                VStack {
                    HStack {
                        Button(action: {
                            selectedPark = nil
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red)
                                .padding()
                        }
                        VStack {
                            Text(park.name)
                                .font(.headline)
                            Text(park.city_name)
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
                }
                .onTapGesture {
                    selectedPark = nil
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
}




#Preview {
    MapView()
}
