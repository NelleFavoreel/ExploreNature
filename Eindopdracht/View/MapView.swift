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
        ZStack(alignment: .topTrailing) {
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: viewModel.posts) { park in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(park.lat) ?? 0, longitude: Double(park.long) ?? 0)) {
                    Image(systemName: "tree.fill")
                        .foregroundColor(Color.green)
                        .frame(width: 30, height: 30)
                        .background(Circle().fill(Color.white).frame(width: 36, height: 36))
                        .shadow(radius: 3)
                        .onTapGesture {
                            withAnimation {
                                self.selectedPark = park
                            }
                        }
                }
            }
            .edgesIgnoringSafeArea(.top)
            .onAppear {
                viewModel.fetchPosts()
                locationManager.requestWhenInUseAuthorization()
            }

            if let park = selectedPark {
                VStack {
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.selectedPark = nil
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.black)
                                .padding()
                        }
                        VStack(alignment: .leading) {
                            Text(park.name)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.green)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            Text(park.city_name)
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(width: 250)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
                }
                .onTapGesture {
                    withAnimation {
                        self.selectedPark = nil
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .transition(.move(edge: .bottom))
            }
        }
    }
}

#Preview {
    MapView()
}

