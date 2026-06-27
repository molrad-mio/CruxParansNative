import SwiftUI

struct ProfileDetailView: View {
    let profile: UserProfile
    
    @State private var textScale: CGFloat = 1.0
    @State private var isPapyrusMode: Bool = false
    
    // Dynamic Astronomical Data
    @State private var heliacalRisingStar: String = "Calculating..."
    @State private var heliacalSettingStar: String = "Calculating..."
    
    @State private var planetParans: [(planet: String, angle1: String, star: String, angle2: String, orb: String)] = []
    @State private var axisParans: [(axis: String, star: String, orb: String)] = []
    
    @State private var selectedEventID: String? = nil
    @State private var showPastEvents: Bool = false
    @State private var targetYear: Int = 2026
    
    // Solar Return State
    @State private var solarReturnMomentString: String = "Calculating..."
    @State private var solarReturnParans: [String] = []
    
    // Relocation State
    @State private var showRelocationSheet: Bool = false
    @State private var isCalculatingRelocation: Bool = false
    @State private var luckyDestinations: [(city: String, results: [String])] = []
    
    // Medical Grade Colors & Vintage Accents
    let paperWhite = Color(red: 245/255, green: 245/255, blue: 220/255)
    let papyrusColor = Color(red: 232/255, green: 220/255, blue: 196/255)
    let deepNavyBlack = Color(red: 10/255, green: 17/255, blue: 40/255)
    let vintageBrown = Color(red: 139/255, green: 69/255, blue: 19/255) // SaddleBrown for a leather/parchment vibe

    private var timelineEvents: [(id: String, type: String, date: String, description: String)] {
        // Dynamic mock data based on the selected year
        let offset1 = (targetYear * 3) % 28 + 1
        let offset2 = (targetYear * 7) % 28 + 1
        let offset3 = (targetYear * 11) % 28 + 1
        
        return [
            ("Event0", "P", String(format: "%04d.03.%02d 08:20", targetYear, offset1), "P-Mars at IC X N-Algol at DSC"),
            ("Event1", "T", String(format: "%04d.06.%02d 13:31", targetYear, offset2), "T-Jupiter at ASC X N-Spica at MC"),
            ("Event2", "P", String(format: "%04d.10.%02d 09:15", targetYear, offset3), "P-Sun at MC X N-Regulus at ASC")
        ]
    }

    var body: some View {
        let bgColor = isPapyrusMode ? papyrusColor : paperWhite
        
        ZStack {
            bgColor.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // 1. HELIACAL STARS (DYNAMIC CALCULATION)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("[ 1. HELIACAL STARS ]")
                            .font(.system(size: 18 * textScale, weight: .bold))
                        Text("- Heliacal Rising Star: \(heliacalRisingStar)")
                            .font(.system(size: 16 * textScale, weight: .bold))
                        Text("- Heliacal Setting Star: \(heliacalSettingStar)")
                            .font(.system(size: 16 * textScale, weight: .bold))
                        Text("- Sect of Birth: Diurnal (Day)")
                            .font(.system(size: 16 * textScale, weight: .bold))
                    }
                    
                    // 2. PLANET X STAR PARANS
                    VStack(alignment: .leading, spacing: 8) {
                        Text("[ 2. PLANET X STAR PARANS ]")
                            .font(.system(size: 18 * textScale, weight: .bold))
                            
                        let groupedPlanets = Dictionary(grouping: planetParans, by: { $0.planet })
                        let sortedPlanets = ["Sun", "Moon", "Mercury", "Venus", "Mars", "Jupiter", "Saturn"].filter { groupedPlanets.keys.contains($0) }
                        
                        ForEach(Array(sortedPlanets.enumerated()), id: \.offset) { index, planet in
                            if index > 0 {
                                Divider().background(deepNavyBlack.opacity(0.3)).padding(.vertical, 4)
                            }
                            
                            if let paransForPlanet = groupedPlanets[planet] {
                                ForEach(Array(paransForPlanet.enumerated()), id: \.offset) { pIndex, paran in
                                    HStack(alignment: .top, spacing: 4) {
                                        Text("-")
                                            .font(.system(size: 16 * textScale, weight: .bold))
                                        
                                        Text("\(paran.planet)")
                                            .font(.system(size: 16 * textScale, weight: .heavy))
                                        
                                        Text("(\(paran.angle1)) ✕ \(paran.star) (\(paran.angle2)) [Orb: \(paran.orb)]")
                                            .font(.system(size: 16 * textScale, weight: .regular))
                                    }
                                }
                            }
                        }
                    }
                    
                    // 3. AXIS X STAR PARANS
                    VStack(alignment: .leading, spacing: 8) {
                        Text("[ 3. AXIS X STAR PARANS ]")
                            .font(.system(size: 18 * textScale, weight: .bold))
                            
                        let groupedAxes = Dictionary(grouping: axisParans, by: { $0.axis })
                        let sortedAxes = ["ASC", "MC", "DSC", "IC"].filter { groupedAxes.keys.contains($0) }
                        
                        ForEach(Array(sortedAxes.enumerated()), id: \.offset) { index, axis in
                            if index > 0 {
                                Divider().background(deepNavyBlack.opacity(0.3)).padding(.vertical, 4)
                            }
                            
                            if let paransForAxis = groupedAxes[axis] {
                                ForEach(Array(paransForAxis.enumerated()), id: \.offset) { pIndex, paran in
                                    HStack(alignment: .top, spacing: 4) {
                                        Text("-")
                                            .font(.system(size: 16 * textScale, weight: .bold))
                                        
                                        Text("\(paran.axis)")
                                            .font(.system(size: 16 * textScale, weight: .heavy))
                                        
                                        Text("✕ \(paran.star) [Orb: \(paran.orb)]")
                                            .font(.system(size: 16 * textScale, weight: .regular))
                                    }
                                }
                            }
                        }
                    }
                    
                    Divider().background(deepNavyBlack)
                    
                    // SOLAR RETURN & TIMELINE YEAR SELECTOR
                    HStack {
                        Button(action: { targetYear -= 1 }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20, weight: .bold))
                                .padding(.horizontal)
                        }
                        
                        Spacer()
                        
                        Text("[ 🔍 YEAR: \(String(targetYear)) ]")
                            .font(.system(size: 20 * textScale, weight: .bold))
                        
                        Spacer()
                        
                        Button(action: {
                            targetYear += 1
                            calculateSolarReturn()
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 20, weight: .bold))
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical, 8)
                    .foregroundColor(deepNavyBlack)
                    .background(papyrusColor.opacity(0.3))
                    .cornerRadius(8)
                    
                    Divider().background(deepNavyBlack)
                    
                    // TRIPLE-LAYER TIMELINE
                    VStack(alignment: .leading, spacing: 16) {
                        Text("[ \(String(targetYear)) TRIPLE-LAYER PARANS TIMELINE ]")
                            .font(.system(size: 18 * textScale, weight: .bold))
                        
                        let currentDateStr = "2026.06.27" // Mock today
                        let allEvents = self.timelineEvents
                        
                        let pastEvents = allEvents.filter { $0.2 < currentDateStr }
                        let futureEvents = allEvents.filter { $0.2 >= currentDateStr }
                        
                        // PAST EVENTS ACCORDION
                        if !pastEvents.isEmpty {
                            DisclosureGroup(isExpanded: $showPastEvents) {
                                ForEach(pastEvents, id: \.0) { eventID, type, dateStr, bodyText in
                                    timelineEventRow(eventID: eventID, type: type, dateStr: dateStr, bodyText: bodyText)
                                        .padding(.top, 8)
                                }
                            } label: {
                                Text("▶ View Past Events (\(pastEvents.count))")
                                    .font(.system(size: 16 * textScale, weight: .bold))
                                    .foregroundColor(deepNavyBlack.opacity(0.7))
                            }
                            .accentColor(deepNavyBlack)
                            .padding(.bottom, 8)
                        }
                        
                        // FUTURE EVENTS
                        ForEach(futureEvents, id: \.0) { eventID, type, dateStr, bodyText in
                            timelineEventRow(eventID: eventID, type: type, dateStr: dateStr, bodyText: bodyText)
                        }
                    }
                    
                    Divider().background(deepNavyBlack).padding(.vertical, 10)
                    
                    // EXPORT PDF BUTTON (CLIENT GIFT)
                    if #available(iOS 16.0, *) {
                        if let pdfURL = PDFExporter.generatePDF(
                            profile: profile,
                            heliacalRising: heliacalRisingStar,
                            heliacalSetting: heliacalSettingStar,
                            planetParans: planetParans,
                            axisParans: axisParans,
                            timelineEvents: timelineEvents,
                            targetYear: targetYear
                        ) {
                            ShareLink(item: pdfURL) {
                                HStack {
                                    Spacer()
                                    Image(systemName: "scroll.fill") // Vintage scroll icon
                                        .font(.system(size: 20))
                                    Text("EXPORT CLIENT GIFT (.PDF)")
                                        .font(.custom("Papyrus", size: 18).weight(.bold))
                                    Spacer()
                                }
                                .padding(.vertical, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(papyrusColor)
                                        .shadow(color: deepNavyBlack.opacity(0.3), radius: 4, x: 0, y: 2)
                                )
                                .foregroundColor(vintageBrown)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(vintageBrown.opacity(0.8), lineWidth: 2)
                                )
                            }
                        }
                    }
                    
                    // EXPORT CSV BUTTON (ASTROLOGER DATA)
                    if let csvURL = CSVExporter.generateCSV(profile: profile, heliacalRising: heliacalRisingStar, heliacalSetting: heliacalSettingStar, planetParans: planetParans, axisParans: axisParans, timelineEvents: timelineEvents) {
                        ShareLink(item: csvURL) {
                            HStack {
                                Spacer()
                                Image(systemName: "tablecells.fill") 
                                    .font(.system(size: 18))
                                Text("EXPORT ASTROLOGER DATA (.CSV)")
                                    .font(.system(size: 16, weight: .bold))
                                Spacer()
                            }
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(deepNavyBlack)
                                    .shadow(color: deepNavyBlack.opacity(0.3), radius: 4, x: 0, y: 2)
                            )
                            .foregroundColor(paperWhite)
                        }
                    }
                    
                }
                .padding()
                .foregroundColor(deepNavyBlack)
            }
        }
        .navigationTitle("📊 CLIENT: \(profile.name.uppercased())")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button("[ ᴀA ]") {
                        if textScale == 1.0 { textScale = 1.2 }
                        else if textScale == 1.2 { textScale = 1.5 }
                        else { textScale = 1.0 }
                    }
                    .foregroundColor(deepNavyBlack)
                    .fontWeight(.bold)
                    
                    Button("[ 👁️ Papyrus ]") {
                        isPapyrusMode.toggle()
                    }
                    .foregroundColor(deepNavyBlack)
                    .fontWeight(.bold)
                }
            }
        }
        .toolbarBackground(bgColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            calculateParans()
            calculateSolarReturn()
        }
        .sheet(isPresented: Binding(
            get: { selectedEventID != nil },
            set: { if !$0 { selectedEventID = nil } }
        )) {
            if let eventID = selectedEventID {
                NoteEditorSheet(profile: profile, eventID: eventID)
            }
        }
        .sheet(isPresented: $showRelocationSheet) {
            NavigationView {
                VStack(spacing: 0) {
                    // Header Image or Banner Space
                    Rectangle()
                        .fill(deepNavyBlack)
                        .frame(height: 60)
                        .overlay(
                            HStack {
                                Image(systemName: "airplane.circle.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(papyrusColor)
                                Text("LUCKY DESTINATIONS")
                                    .font(.system(size: 20, weight: .heavy))
                                    .foregroundColor(paperWhite)
                            }
                        )
                    
                    if isCalculatingRelocation {
                        VStack(spacing: 20) {
                            ProgressView()
                                .scaleEffect(1.5)
                            Text("Scanning the globe for perfect planetary alignments...\nThis may take a moment.")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 14))
                                .foregroundColor(deepNavyBlack)
                        }
                        .padding(40)
                        Spacer()
                    } else if luckyDestinations.isEmpty {
                        VStack(spacing: 20) {
                            Text("No major conjunctions found for this year.")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(deepNavyBlack)
                            Text("The stars remain quiet.")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        .padding(40)
                        Spacer()
                    } else {
                        List(luckyDestinations, id: \.city) { dest in
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "mappin.and.ellipse")
                                        .foregroundColor(vintageBrown)
                                    Text(dest.city)
                                        .font(.system(size: 18, weight: .heavy))
                                        .foregroundColor(deepNavyBlack)
                                }
                                ForEach(dest.results, id: \.self) { result in
                                    Text("✦ \(result)")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(deepNavyBlack.opacity(0.8))
                                        .padding(.leading, 24)
                                }
                            }
                            .padding(.vertical, 8)
                            .listRowBackground(papyrusColor.opacity(0.2))
                        }
                        .listStyle(PlainListStyle())
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Close") {
                            showRelocationSheet = false
                        }
                        .foregroundColor(deepNavyBlack)
                        .font(.system(size: 16, weight: .bold))
                    }
                }
            }
        }
    }
    
    private func calculateSolarReturn() {
        self.solarReturnMomentString = "Calculating..."
        self.solarReturnParans = []
        
        Task {
            let birthDate = profile.dateOfBirth
            let calendar = Calendar.current
            let natalMonth = Int32(calendar.component(.month, from: birthDate))
            let natalDay = Int32(calendar.component(.day, from: birthDate))
            
            let jdNatal = AstronomicalMath.shared.julianDay(from: birthDate)
            
            // Using exact moment calculation
            let exactJD = SwephWrapper.shared.calculateSolarReturn(natalJulianDay: jdNatal, targetYear: Int32(targetYear), natalMonth: natalMonth, natalDay: natalDay)
            
            // Format Exact Moment
            let secondsSince1970 = (exactJD - 2440587.5) * 86400.0
            let exactDate = Date(timeIntervalSince1970: secondsSince1970)
            let df = DateFormatter()
            df.dateFormat = "yyyy.MM.dd HH:mm:ss 'UTC'"
            df.timeZone = TimeZone(identifier: "UTC")
            let exactStr = df.string(from: exactDate)
            
            // Calculate Stars for standard Birthplace (Natal Location)
            let stars = AstronomicalMath.shared.calculateSolarReturnStars(exactJD: exactJD, latitude: profile.latitude, longitude: profile.longitude, stars: FixedStarsData.proStars)
            
            await MainActor.run {
                self.solarReturnMomentString = exactStr
                self.solarReturnParans = stars.isEmpty ? ["- No Exact Conjunctions"] : stars.map { "- \($0)" }
            }
        }
    }
    
    private func calculateRelocation() {
        self.isCalculatingRelocation = true
        self.luckyDestinations = []
        
        Task {
            let birthDate = profile.dateOfBirth
            let calendar = Calendar.current
            let natalMonth = Int32(calendar.component(.month, from: birthDate))
            let natalDay = Int32(calendar.component(.day, from: birthDate))
            let jdNatal = AstronomicalMath.shared.julianDay(from: birthDate)
            
            let exactJD = SwephWrapper.shared.calculateSolarReturn(natalJulianDay: jdNatal, targetYear: Int32(targetYear), natalMonth: natalMonth, natalDay: natalDay)
            
            let dest = AstronomicalMath.shared.scanLuckyDestinations(exactJD: exactJD, stars: FixedStarsData.proStars)
            
            await MainActor.run {
                self.luckyDestinations = dest.map { (city: $0.city.displayName, results: $0.results) }
                self.isCalculatingRelocation = false
            }
        }
    }
    
    private func calculateParans() {
        let math = AstronomicalMath.shared
        if let rising = math.calculateHeliacalRisingStar(for: profile.dateOfBirth, latitude: profile.latitude, stars: FixedStarsData.proStars) {
            self.heliacalRisingStar = rising.name
        } else {
            self.heliacalRisingStar = "N/A"
        }
        
        if let setting = math.calculateHeliacalSettingStar(for: profile.dateOfBirth, latitude: profile.latitude, stars: FixedStarsData.proStars) {
            self.heliacalSettingStar = setting.name
        } else {
            self.heliacalSettingStar = "N/A"
        }
        
        let allParans = math.calculateAllParans(
            date: profile.dateOfBirth, 
            latitude: profile.latitude, 
            longitude: profile.longitude, 
            stars: FixedStarsData.proStars
        )
        
        self.planetParans = allParans.planetParans
        self.axisParans = allParans.axisParans
    }
    
    @ViewBuilder
    private func timelineEventRow(eventID: String, type: String, dateStr: String, bodyText: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .center, spacing: 8) {
                Text(type)
                    .font(.system(size: 14 * textScale, weight: .heavy))
                    .foregroundColor(paperWhite)
                    .frame(width: 24, height: 24)
                    .background(type == "T" ? Color.red : Color.blue)
                    .cornerRadius(4)
                    
                Text(dateStr)
                    .font(.system(size: 16 * textScale, weight: .bold))
                    
                Spacer()
            }
            Text(bodyText)
                .font(.system(size: 16 * textScale, weight: .bold))
            
            // NOTE BLOCK
            Button(action: {
                selectedEventID = eventID
            }) {
                HStack(alignment: .top, spacing: 6) {
                    Text("✍")
                        .font(.system(size: 14 * textScale))
                        .foregroundColor(deepNavyBlack.opacity(0.7))
                    
                    if let existingNote = profile.notes.first(where: { $0.eventID == eventID }), !existingNote.content.isEmpty {
                        Text(existingNote.content)
                            .font(.system(size: 14 * textScale, weight: .regular))
                            .foregroundColor(deepNavyBlack)
                            .lineLimit(2)
                            .truncationMode(.tail)
                            .multilineTextAlignment(.leading)
                    } else {
                        Text("Add note...")
                            .font(.system(size: 14 * textScale, weight: .regular))
                            .foregroundColor(deepNavyBlack.opacity(0.4))
                            .italic()
                    }
                    Spacer()
                }
                .padding(8)
                .frame(maxWidth: .infinity, minHeight: 40, alignment: .topLeading)
                .background(papyrusColor.opacity(0.3))
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(deepNavyBlack.opacity(0.1), lineWidth: 1)
                )
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.bottom, 8)
    }
}
