import MapKit
import SwiftUI

struct ParkDetail: View {
    var park: ParkInfo
    @State private var region: MKCoordinateRegion
    @State private var selectedImage: UIImage? 
    
    init(park: ParkInfo) {
        self.park = park
        // Initialiseer de region met de coördinaten van het park
        _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(park.lat) ?? 0, longitude: Double(park.long) ?? 0), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(park.name)
                    .font(.title)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                Text(park.city_name)
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Info")
                        .font(.headline)
                    Text(park.product_description)
                        .foregroundColor(.secondary)
                    Text("Extra")
                        .font(.headline)
                    Text(park.extra_facilities)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                // Mapweergave met dynamische coördinaten
                Map(coordinateRegion: $region, annotationItems: [park]) { park in
                    MapPin(coordinate: CLLocationCoordinate2D(latitude: Double(park.lat) ?? 0, longitude: Double(park.long) ?? 0), tint: .red)
                }
                .frame(height: 300)
                .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Contact:")
                        .font(.headline)
                    Text("Email: \(park.email)")
                    Text("Phone: \(park.phone1)")
                    Text("Website: \(park.website)")
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.horizontal)
                
                Button(action: {
                    // Roep functie aan om foto toe te voegen
                    self.addPhoto()
                }) {
                    HStack {
                        Text("Voeg foto toe:")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Image(systemName: "photo.badge.plus.fill")
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                }
                
                // Geselecteerde afbeelding weergeven
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
            }
            .padding()
        }
        .navigationTitle("Park Detail")
    }
    
    // Functie om foto toe te voegen
    private func addPhoto() {
        // Maak een UIImagePickerController aan
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary // Gebruik de fotobibliotheek als bron
        
        // Geef de gebruiker de mogelijkheid om een afbeelding te selecteren
        UIApplication.shared.windows.first?.rootViewController?.present(imagePicker, animated: true, completion: nil)
    }
}

struct ParkDetail_Previews: PreviewProvider {
    static var previews: some View {
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
}
