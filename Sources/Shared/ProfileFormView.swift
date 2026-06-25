import SwiftUI
import SwiftData
import CoreLocation

struct ProfileFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var birthTime: Date = Date()
    @State private var city: String = ""
    
    @State private var isGeocoding: Bool = false
    @State private var errorMessage: String? = nil
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Basic Information")) {
                    TextField("Name", text: $name)
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                    DatePicker("Birth Time", selection: $birthTime, displayedComponents: .hourAndMinute)
                }
                
                Section(header: Text("Location (Crucial for Parans)"), footer: Text("Enter a city name (e.g., Tokyo, London, New York). The exact latitude and longitude will be calculated automatically.")) {
                    TextField("Birth City", text: $city)
                }
                
                if let errorMessage = errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("New Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveProfile()
                    }
                    .disabled(name.isEmpty || city.isEmpty || isGeocoding)
                }
            }
            .overlay {
                if isGeocoding {
                    ProgressView("Calculating Coordinates...")
                        .padding()
                        .background(Color(.systemBackground).opacity(0.8))
                        .cornerRadius(10)
                }
            }
        }
    }
    
    private func saveProfile() {
        isGeocoding = true
        errorMessage = nil
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { placemarks, error in
            DispatchQueue.main.async {
                isGeocoding = false
                
                if let error = error {
                    errorMessage = "Could not find coordinates for '\(city)'. Please try a larger nearby city."
                    print("Geocoding error: \(error)")
                    return
                }
                
                guard let location = placemarks?.first?.location else {
                    errorMessage = "Location data is missing."
                    return
                }
                
                let lat = location.coordinate.latitude
                let lon = location.coordinate.longitude
                let confirmedCity = placemarks?.first?.locality ?? city
                
                let newProfile = UserProfile(
                    name: name,
                    dateOfBirth: dateOfBirth,
                    birthTime: birthTime,
                    birthCity: confirmedCity,
                    latitude: lat,
                    longitude: lon
                )
                
                modelContext.insert(newProfile)
                
                do {
                    try modelContext.save()
                    dismiss()
                } catch {
                    errorMessage = "Failed to save profile: \(error.localizedDescription)"
                }
            }
        }
    }
}
