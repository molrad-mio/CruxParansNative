import Foundation

public class CSVExporter {
    
    public static func generateCSV(profile: UserProfile,
                                   heliacalRising: String,
                                   heliacalSetting: String,
                                   planetParans: [(planet: String, angle1: String, star: String, angle2: String, orb: String)],
                                   axisParans: [(axis: String, star: String, orb: String)]) -> URL? {
        
        var csvString = "Crux Parans Pro - Astrological Report\n"
        csvString += "Client Name, \(profile.name)\n"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        csvString += "Date of Birth, \(dateFormatter.string(from: profile.dateOfBirth))\n"
        csvString += "Birth City, \(profile.birthCity)\n"
        csvString += "Coordinates, \(profile.latitude) / \(profile.longitude)\n\n"
        
        csvString += "--- HELIACAL STARS ---\n"
        csvString += "Rising Star, \(heliacalRising)\n"
        csvString += "Setting Star, \(heliacalSetting)\n\n"
        
        csvString += "--- PLANET X STAR PARANS ---\n"
        csvString += "Planet,Angle,Star,Angle,Orb\n"
        for p in planetParans {
            csvString += "\(p.planet),\(p.angle1),\(p.star),\(p.angle2),\(p.orb)\n"
        }
        csvString += "\n"
        
        csvString += "--- AXIS X STAR PARANS ---\n"
        csvString += "Axis,Star,Orb\n"
        for a in axisParans {
            csvString += "\(a.axis),\(a.star),\(a.orb)\n"
        }
        csvString += "\n"
        
        csvString += "--- PROFESSIONAL NOTES ---\n"
        csvString += "Event ID,Note,Timestamp\n"
        for note in profile.notes {
            csvString += "\(note.eventID),\"\(note.content.replacingOccurrences(of: "\"", with: "\"\""))\",\(dateFormatter.string(from: note.timestamp))\n"
        }
        
        let fileName = "\(profile.name.replacingOccurrences(of: " ", with: "_"))_Parans_Report.csv"
        let tempDirectoryURL = FileManager.default.temporaryDirectory
        let fileURL = tempDirectoryURL.appendingPathComponent(fileName)
        
        do {
            try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
            return fileURL
        } catch {
            print("Failed to create CSV file: \(error)")
            return nil
        }
    }
}
