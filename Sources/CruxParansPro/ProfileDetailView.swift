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
    
    // Medical Grade Colors & Vintage Accents
    let paperWhite = Color(red: 245/255, green: 245/255, blue: 220/255)
    let papyrusColor = Color(red: 232/255, green: 220/255, blue: 196/255)
    let deepNavyBlack = Color(red: 10/255, green: 17/255, blue: 40/255)
    let vintageBrown = Color(red: 139/255, green: 69/255, blue: 19/255) // SaddleBrown for a leather/parchment vibe


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
                    
                    // SOLAR RETURN
                    VStack(alignment: .center, spacing: 8) {
                        Text("[ 🔍 ENTER YEAR: 2026 ]")
                            .font(.system(size: 20 * textScale, weight: .bold))
                            .frame(maxWidth: .infinity)
                    }
                    
                    Divider().background(deepNavyBlack)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("[ 2026 SOLAR RETURN STARS ]")
                            .font(.system(size: 18 * textScale, weight: .bold))
                        Text("Exact Moment: 2026.06.24 13:31:05")
                            .font(.system(size: 14 * textScale, weight: .bold))
                            .foregroundColor(deepNavyBlack.opacity(0.7))
                        Text("- ASC ✕ Regulus [Orb: 0°12']")
                            .font(.system(size: 16 * textScale, weight: .bold))
                        Text("- MC ✕ Spica [Orb: 0°34']")
                            .font(.system(size: 16 * textScale, weight: .bold))
                    }
                    
                    // TRIPLE-LAYER TIMELINE
                    VStack(alignment: .leading, spacing: 16) {
                        Text("[ 2026 TRIPLE-LAYER PARANS TIMELINE ]")
                            .font(.system(size: 18 * textScale, weight: .bold))
                        
                        let currentDateStr = "2026.06.27" // Mock today
                        let allEvents = [
                            ("Event0", "P", "2026.03.15 08:20", "P-Mars at IC ✕ N-Algol at DSC"),
                            ("Event1", "T", "2026.06.24 13:31", "T-Jupiter at ASC ✕ N-Spica at MC"),
                            ("Event2", "P", "2026.10.12 09:15", "P-Sun at MC ✕ N-Regulus at ASC")
                        ]
                        
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
                    
                    // EXPORT CSV BUTTON
                    if let csvURL = CSVExporter.generateCSV(profile: profile, heliacalRising: heliacalRisingStar, heliacalSetting: heliacalSettingStar, planetParans: planetParans, axisParans: axisParans) {
                        ShareLink(item: csvURL) {
                            HStack {
                                Spacer()
                                Image(systemName: "scroll.fill") // Vintage scroll icon
                                    .font(.system(size: 20))
                                Text("EXPORT PARANS SCROLL (.CSV)")
                                    .font(.custom("Papyrus", size: 18).weight(.bold))
                                Spacer()
                            }
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(vintageBrown)
                                    .shadow(color: deepNavyBlack.opacity(0.3), radius: 4, x: 0, y: 2)
                            )
                            .foregroundColor(papyrusColor)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(papyrusColor.opacity(0.5), lineWidth: 1)
                            )
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
        }
        .sheet(isPresented: Binding(
            get: { selectedEventID != nil },
            set: { if !$0 { selectedEventID = nil } }
        )) {
            if let eventID = selectedEventID {
                NoteEditorSheet(profile: profile, eventID: eventID)
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
                Button("[ ✎ ]") {
                    selectedEventID = eventID
                }
                .font(.system(size: 16 * textScale, weight: .bold))
                .foregroundColor(deepNavyBlack)
            }
            Text(bodyText)
                .font(.system(size: 16 * textScale, weight: .bold))
            
            if let existingNote = profile.notes.first(where: { $0.eventID == eventID }), !existingNote.content.isEmpty {
                Text("✍：\(existingNote.content)")
                    .font(.system(size: 14 * textScale, weight: .bold))
                    .padding(.top, 4)
            }
        }
        .padding(.bottom, 8)
    }
}
