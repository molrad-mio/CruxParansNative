import SwiftUI

// クライアントにお渡しするための「魔法の巻物」PDFビュー（占い師のメモは完全に除外されています）
@available(iOS 16.0, *)
struct ReportPDFView: View {
    let profile: UserProfile
    let heliacalRisingStar: String
    let heliacalSettingStar: String
    let planetParans: [(planet: String, angle1: String, star: String, angle2: String, orb: String)]
    let axisParans: [(axis: String, star: String, orb: String)]
    let timelineEvents: [(id: String, type: String, date: String, description: String)]
    let targetYear: Int

    let papyrusColor = Color(red: 232/255, green: 220/255, blue: 196/255)
    let deepNavyBlack = Color(red: 10/255, green: 17/255, blue: 40/255)

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            // HEADER
            VStack(alignment: .center, spacing: 12) {
                Text("ASTROLOGICAL PARANS SCROLL")
                    .font(.custom("Papyrus", size: 32).weight(.bold))
                    .multilineTextAlignment(.center)
                
                Text("Client: \(profile.name.uppercased())")
                    .font(.system(size: 22, weight: .bold))
                
                let df = DateFormatter()
                let _ = { df.dateStyle = .medium; df.timeStyle = .short }()
                Text("Date of Birth: \(df.string(from: profile.dateOfBirth))")
                    .font(.system(size: 16))
                
                Text("Location: \(profile.birthCity) (\(String(format: "%.2f", profile.latitude)), \(String(format: "%.2f", profile.longitude)))")
                    .font(.system(size: 16))
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 16)
            
            Divider().background(deepNavyBlack).frame(height: 2)
            
            // 1. HELIACAL STARS
            VStack(alignment: .leading, spacing: 8) {
                Text("[ HELIACAL STARS ]")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 4)
                
                Text("- Heliacal Rising Star: ")
                    .font(.system(size: 16)) +
                Text(heliacalRisingStar)
                    .font(.system(size: 16, weight: .bold))
                
                Text("- Heliacal Setting Star: ")
                    .font(.system(size: 16)) +
                Text(heliacalSettingStar)
                    .font(.system(size: 16, weight: .bold))
            }
            
            Divider().background(deepNavyBlack.opacity(0.5))
            
            // 2. PLANET X STAR PARANS
            VStack(alignment: .leading, spacing: 8) {
                Text("[ PLANET X STAR PARANS ]")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 4)
                
                let groupedPlanets = Dictionary(grouping: planetParans, by: { $0.planet })
                let sortedPlanets = ["Sun", "Moon", "Mercury", "Venus", "Mars", "Jupiter", "Saturn"].filter { groupedPlanets.keys.contains($0) }
                
                ForEach(sortedPlanets, id: \.self) { planet in
                    if let paransForPlanet = groupedPlanets[planet] {
                        ForEach(Array(paransForPlanet.enumerated()), id: \.offset) { index, paran in
                            Text("- ")
                                .font(.system(size: 16)) +
                            Text(paran.planet)
                                .font(.system(size: 16, weight: .heavy)) +
                            Text(" (\(paran.angle1)) ✕ \(paran.star) (\(paran.angle2)) [Orb: \(paran.orb)]")
                                .font(.system(size: 16))
                        }
                        .padding(.bottom, 2)
                    }
                }
            }
            
            Divider().background(deepNavyBlack.opacity(0.5))
            
            // 3. AXIS X STAR PARANS
            VStack(alignment: .leading, spacing: 8) {
                Text("[ AXIS X STAR PARANS ]")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 4)
                
                let groupedAxes = Dictionary(grouping: axisParans, by: { $0.axis })
                let sortedAxes = ["ASC", "MC", "DSC", "IC"].filter { groupedAxes.keys.contains($0) }
                
                ForEach(sortedAxes, id: \.self) { axis in
                    if let paransForAxis = groupedAxes[axis] {
                        ForEach(Array(paransForAxis.enumerated()), id: \.offset) { index, paran in
                            Text("- ")
                                .font(.system(size: 16)) +
                            Text(paran.axis)
                                .font(.system(size: 16, weight: .heavy)) +
                            Text(" ✕ \(paran.star) [Orb: \(paran.orb)]")
                                .font(.system(size: 16))
                        }
                        .padding(.bottom, 2)
                    }
                }
            }
            
            Divider().background(deepNavyBlack).frame(height: 2)
            
            // TIMELINE (NO NOTES INCLUDED)
            VStack(alignment: .leading, spacing: 12) {
                Text("[ \(String(targetYear)) PARANS TIMELINE ]")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 4)
                
                ForEach(timelineEvents, id: \.id) { event in
                    HStack(alignment: .top, spacing: 12) {
                        Text("[\(event.type)]")
                            .font(.system(size: 14, weight: .heavy))
                            .foregroundColor(papyrusColor)
                            .frame(width: 28, height: 28)
                            .background(event.type == "T" ? Color.red.opacity(0.8) : Color.blue.opacity(0.8))
                            .cornerRadius(4)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(event.date)
                                .font(.system(size: 16, weight: .bold))
                            Text(event.description)
                                .font(.system(size: 16))
                        }
                    }
                    .padding(.bottom, 8)
                }
            }
            
            Spacer()
        }
        .padding(40)
        .frame(width: 650) // 巻物としての固定幅を設定（高さは中身に合わせて自動で伸びる）
        .background(papyrusColor)
        .foregroundColor(deepNavyBlack)
        .overlay(
            // 装飾的な外枠
            Rectangle()
                .stroke(deepNavyBlack.opacity(0.7), lineWidth: 3)
                .padding(12)
        )
        .overlay(
            // 内側の細い枠
            Rectangle()
                .stroke(deepNavyBlack.opacity(0.3), lineWidth: 1)
                .padding(18)
        )
    }
}

public class PDFExporter {
    
    @available(iOS 16.0, *)
    @MainActor
    public static func generatePDF(profile: UserProfile,
                                   heliacalRising: String,
                                   heliacalSetting: String,
                                   planetParans: [(planet: String, angle1: String, star: String, angle2: String, orb: String)],
                                   axisParans: [(axis: String, star: String, orb: String)],
                                   timelineEvents: [(id: String, type: String, date: String, description: String)],
                                   targetYear: Int) -> URL? {
        
        let pdfView = ReportPDFView(
            profile: profile,
            heliacalRisingStar: heliacalRising,
            heliacalSettingStar: heliacalSetting,
            planetParans: planetParans,
            axisParans: axisParans,
            timelineEvents: timelineEvents,
            targetYear: targetYear
        )
        
        let renderer = ImageRenderer(content: pdfView)
        // 背景や枠線をベクターとして綺麗に描画するための設定
        renderer.scale = 2.0 
        
        // ImageRendererはViewのコンテンツに基づいて自動的に高さを決定します。
        // これにより「巻物」のような1枚の縦長のPDFが生成されます。
        
        let fileName = "\(profile.name.replacingOccurrences(of: " ", with: "_"))_Scroll.pdf"
        let tempDirectoryURL = FileManager.default.temporaryDirectory
        let fileURL = tempDirectoryURL.appendingPathComponent(fileName)
        
        renderer.render { size, context in
            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            guard let pdfContext = CGContext(fileURL as CFURL, mediaBox: &box, nil) else { return }
            
            pdfContext.beginPDFPage(nil)
            context(pdfContext)
            pdfContext.endPDFPage()
            pdfContext.closePDF()
        }
        
        return fileURL
    }
}
