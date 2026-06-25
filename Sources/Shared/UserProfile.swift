import Foundation
import SwiftData

@Model
public final class UserProfile {
    public var id: UUID
    public var name: String
    public var dateOfBirth: Date
    public var birthTime: Date
    
    // For Fixed Star Astrology (Parans), exact Latitude is critical.
    public var birthCity: String
    public var latitude: Double
    public var longitude: Double
    
    public init(name: String, dateOfBirth: Date, birthTime: Date, birthCity: String, latitude: Double, longitude: Double) {
        self.id = UUID()
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.birthTime = birthTime
        self.birthCity = birthCity
        self.latitude = latitude
        self.longitude = longitude
    }
}
