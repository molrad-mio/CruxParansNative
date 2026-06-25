import SwiftUI
import SwiftData
import CoreLocation

struct LightContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var dateOfBirth: Date = Date()
    @State private var city: String = "Tokyo"
    @State private var latitude: Double = 35.6895
    
    @State private var topStar: String = "Galactic Center"
    @State private var topStarType: String = "None"
    
    @State private var isCalculating: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    // Input Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Discover Your Soul's Star")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        DatePicker("Birth Date", selection: $dateOfBirth, displayedComponents: .date)
                            .colorScheme(.dark)
                        
                        HStack {
                            Text("Birth City")
                                .foregroundColor(.white)
                            Spacer()
                            TextField("e.g. Tokyo", text: $city)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.cyan)
                        }
                        
                        Button(action: calculateMyStar) {
                            Text("CALCULATE MY STAR")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.cyan)
                                .cornerRadius(10)
                        }
                        .disabled(isCalculating)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    // Result Section
                    VStack(spacing: 15) {
                        Text("Your Heliacal Rising Star")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .tracking(2)
                        
                        Text(topStar.uppercased())
                            .font(.system(size: 40, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: .cyan, radius: 10, x: 0, y: 0)
                        
                        Text("TYPE: \(topStarType.uppercased())")
                            .font(.headline)
                            .foregroundColor(topStarType == "Royal" ? .yellow : .cyan)
                    }
                    
                    Spacer()
                    
                    // Social Share Button
                    Button(action: shareToInstagram) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("Share to Social Media")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(30)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("Crux Parans Light")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            calculateMyStar()
        }
    }
    
    private func calculateMyStar() {
        isCalculating = true
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { placemarks, error in
            DispatchQueue.main.async {
                if let location = placemarks?.first?.location {
                    self.latitude = location.coordinate.latitude
                }
                
                // Set default longitude if not retrieved (for accuracy, Geocoder should really return longitude too)
                let lon = placemarks?.first?.location?.coordinate.longitude ?? 139.6917 // Tokyo default
                
                // Perform Astronomical Math
                let math = AstronomicalMath.shared
                let allParans = math.calculateAllParans(
                    date: dateOfBirth, 
                    latitude: latitude, 
                    longitude: lon, 
                    stars: FixedStarsData.lightStars
                )
                
                // Collect all unique stars that formed at least one paran
                var paranStars = Set<String>()
                for p in allParans.planetParans { paranStars.insert(p.2) } // p.2 is starName
                for a in allParans.axisParans { paranStars.insert(a.1) }   // a.1 is starName
                
                if paranStars.isEmpty {
                    self.topStar = "Galactic Center"
                    self.topStarType = "None"
                } else {
                    let typeRanks: [String: Int] = ["Royal": 4, "Intense": 3, "Crossroad": 2, "Karma": 1]
                    
                    // Map star names back to FixedStar objects to check their types
                    let matchedStarObjects = FixedStarsData.lightStars.filter { paranStars.contains($0.name) }
                    
                    // Sort by highest rank first
                    let sortedStars = matchedStarObjects.sorted { s1, s2 in
                        let rank1 = typeRanks[s1.type] ?? 0
                        let rank2 = typeRanks[s2.type] ?? 0
                        return rank1 > rank2
                    }
                    
                    if let highestStar = sortedStars.first {
                        self.topStar = highestStar.name
                        self.topStarType = highestStar.type
                    } else {
                        self.topStar = "Galactic Center"
                        self.topStarType = "None"
                    }
                }
                
                isCalculating = false
            }
        }
    }
    
    private func shareToInstagram() {
        let textToShare = "My soul's fixed star is \(topStar)! Discover yours with Crux Parans Light. #CruxParans #\(topStar.replacingOccurrences(of: " ", with: ""))Tribe"
        let activityVC = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootVC = window.rootViewController {
            // For iPad compatibility
            if let popover = activityVC.popoverPresentationController {
                popover.sourceView = window
                popover.sourceRect = CGRect(x: window.bounds.midX, y: window.bounds.midY, width: 0, height: 0)
                popover.permittedArrowDirections = []
            }
            rootVC.present(activityVC, animated: true, completion: nil)
        }
    }
}
