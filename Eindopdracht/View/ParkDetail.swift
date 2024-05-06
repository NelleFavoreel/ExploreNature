//
//  ParkDetail.swift
//  Eindopdracht
//
//  Created by Nelle Favoreel on 04/04/2024.
//


import MapKit
import SwiftUI

struct ParkDetail: View {
    var park: ParkInfo // Assuming ParkInfo is the model for park details
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.39135358516022, longitude: 4.466165866998104), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    var body: some View {
        List {
            VStack {
                Text(park.name)
                Text(park.city_name)
            }.padding(.vertical, 100.0)
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Info")
                    Text(park.product_description)
                }
                VStack(alignment: .leading) {
                    Text("Extra:")
                    Text(park.extra_facilities)
                }
            }.frame(maxWidth: 350, alignment: .leading)
            .padding(.bottom, 100.0)
            
            Map(coordinateRegion: $region, annotationItems: [park]) { park in
                MapPin(coordinate: CLLocationCoordinate2D(latitude: Double(park.lat) ?? 0, longitude: Double(park.long) ?? 0), tint: .red)
            }
            .frame(height: 300)
            .padding(.bottom, 30.0)
            VStack(alignment: .leading) {
                Text(park.email)
                    .font(.footnote)
                Text(park.phone1)
                    .font(.footnote)
                Text(park.website)
                    .font(.footnote)
            }.frame(maxWidth: 350, alignment: .leading)
            HStack{
                Text("Voeg foto toe:")
                Image(systemName: "photo.badge.plus.fill")
            }
        }
        .navigationTitle("Park Detail")
    }
}

#Preview {
    ParkDetail(park: ParkInfo(
        business_product_id: "123456",
        name: "Sample Park",
        city_name: "Sample City",
        product_description: "Sample description",
        promotional_region: "Sample region",
        extra_facilities: "Sample facilities",
        phone1: "123-456-7890",
        email: "sample@example.com",
        website: "https://example.com",
        lat: "51.39135358516022",
        long: "4.466165866998104"
    ))
}



