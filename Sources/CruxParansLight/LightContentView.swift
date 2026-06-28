import SwiftUI
import CoreLocation

struct LightContentView: View {
    @State private var dateOfBirth: Date = Date()
    @State private var timeString: String = "12:00"
    @State private var latitude: String = "35.6895"
    @State private var longitude: String = "139.6917"
    
    @State private var isCalculating: Bool = false
    @State private var resolvedStar: GuildStar? = nil
    
    // Gothic Colors
    let obsidianBlack = Color(red: 10/255, green: 10/255, blue: 15/255)
    let bloodCrimson = Color(red: 138/255, green: 3/255, blue: 3/255)
    let oldGold = Color(red: 197/255, green: 179/255, blue: 88/255)
    let darkGray = Color(white: 0.15)
    
    var body: some View {
        NavigationStack {
            ZStack {
                obsidianBlack.ignoresSafeArea()
                
                // Background pattern or aura
                Circle()
                    .fill(bloodCrimson.opacity(0.1))
                    .frame(width: 300, height: 300)
                    .blur(radius: 50)
                    .offset(y: -150)
                
                ScrollView {
                    VStack(spacing: 30) {
                        
                        Text("Crux Guild")
                            .font(.custom("Palatino-Bold", size: 40))
                            .foregroundColor(oldGold)
                            .shadow(color: oldGold.opacity(0.5), radius: 10, x: 0, y: 0)
                            .padding(.top, 40)
                        
                        Text("Unveil the star that locked thy soul at the moment of thy first breath.")
                            .font(.custom("Palatino-Italic", size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                        
                        VStack(spacing: 20) {
                            // Date Input
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Date of Birth")
                                    .font(.custom("Palatino-Bold", size: 14))
                                    .foregroundColor(oldGold)
                                DatePicker("", selection: $dateOfBirth, displayedComponents: .date)
                                    .labelsHidden()
                                    .colorScheme(.dark)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            // Time Input
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Time (HH:mm)")
                                    .font(.custom("Palatino-Bold", size: 14))
                                    .foregroundColor(oldGold)
                                TextField("12:00", text: $timeString)
                                    .keyboardType(.numbersAndPunctuation)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(darkGray)
                                    .cornerRadius(8)
                            }
                            
                            // Coordinates Input
                            HStack(spacing: 15) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Latitude")
                                        .font(.custom("Palatino-Bold", size: 14))
                                        .foregroundColor(oldGold)
                                    TextField("35.6895", text: $latitude)
                                        .keyboardType(.numbersAndPunctuation)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(darkGray)
                                        .cornerRadius(8)
                                }
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Longitude")
                                        .font(.custom("Palatino-Bold", size: 14))
                                        .foregroundColor(oldGold)
                                    TextField("139.6917", text: $longitude)
                                        .keyboardType(.numbersAndPunctuation)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(darkGray)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                        
                        Button(action: calculateStar) {
                            if isCalculating {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: obsidianBlack))
                            } else {
                                Text("Reveal Thy Fate")
                                    .font(.custom("Palatino-Bold", size: 18))
                            }
                        }
                        .foregroundColor(obsidianBlack)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(oldGold)
                        .cornerRadius(8)
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                        .disabled(isCalculating)
                        
                    }
                }
            }
            .navigationDestination(item: $resolvedStar) { star in
                ResultView(guildStar: star)
            }
        }
    }
    
    private func calculateStar() {
        guard let lat = Double(latitude), let lon = Double(longitude) else { return }
        
        isCalculating = true
        
        // Combine date and time
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: dateOfBirth).prefix(10) + " " + timeString
        
        let finalDate = formatter.date(from: String(dateString)) ?? dateOfBirth
        
        DispatchQueue.global(qos: .userInitiated).async {
            // Find Heliacal Rising Star
            let math = AstronomicalMath.shared
            let risingStarOpt = math.calculateHeliacalRisingStar(for: finalDate, latitude: lat, stars: FixedStarsData.proStars)
            
            DispatchQueue.main.async {
                if let risingStarName = risingStarOpt?.name,
                   let guildStar = GuildStarsData.getGuildStar(forName: risingStarName) {
                    self.resolvedStar = guildStar
                } else {
                    self.resolvedStar = GuildStarsData.noneStar
                }
                self.isCalculating = false
            }
        }
    }
}

extension GuildStar: Identifiable, Hashable {
    public var id: String { name }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    public static func ==(lhs: GuildStar, rhs: GuildStar) -> Bool {
        return lhs.name == rhs.name
    }
}
