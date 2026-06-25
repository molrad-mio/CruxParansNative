import Foundation

public struct FixedStar: Identifiable {
    public let id = UUID()
    public let name: String
    public let type: String // "Royal", "Intense", "Crossroad", "Karma"
    public let rightAscension: Double // RA in degrees (0 to 360)
    public let declination: Double    // Dec in degrees (-90 to +90)
    
    public init(name: String, type: String, rightAscension: Double, declination: Double) {
        self.name = name
        self.type = type
        self.rightAscension = rightAscension
        self.declination = declination
    }
}

public struct FixedStarsData {
    // Exact J2000 epoch coordinates for the 30 Pro Edition Fixed Stars
    // (Approximated for this initial architecture, to be fine-tuned via Swiss Ephemeris API later)
    public static let proStars: [FixedStar] = [
        FixedStar(name: "Aldebaran", type: "Royal", rightAscension: 68.98, declination: 16.51),
        FixedStar(name: "Antares", type: "Royal", rightAscension: 247.35, declination: -26.43),
        FixedStar(name: "Regulus", type: "Royal", rightAscension: 152.09, declination: 11.97),
        FixedStar(name: "Fomalhaut", type: "Royal", rightAscension: 344.41, declination: -29.62),
        
        FixedStar(name: "Sirius", type: "Intense", rightAscension: 101.28, declination: -16.71),
        FixedStar(name: "Canopus", type: "Intense", rightAscension: 95.98, declination: -52.69),
        FixedStar(name: "Rigel", type: "Intense", rightAscension: 78.63, declination: -8.20),
        FixedStar(name: "Spica", type: "Intense", rightAscension: 201.29, declination: -11.16),
        FixedStar(name: "Vega", type: "Intense", rightAscension: 279.23, declination: 38.78),
        FixedStar(name: "Capella", type: "Intense", rightAscension: 79.17, declination: 45.99),
        FixedStar(name: "Arcturus", type: "Intense", rightAscension: 213.91, declination: 19.18),
        FixedStar(name: "Procyon", type: "Intense", rightAscension: 114.82, declination: 5.22),
        FixedStar(name: "Achernar", type: "Intense", rightAscension: 24.42, declination: -57.23),
        FixedStar(name: "Betelgeuse", type: "Intense", rightAscension: 88.79, declination: 7.40),
        FixedStar(name: "Altair", type: "Intense", rightAscension: 297.69, declination: 8.86),
        FixedStar(name: "Algol", type: "Intense", rightAscension: 47.04, declination: 40.95),
        FixedStar(name: "Alcyone", type: "Intense", rightAscension: 56.87, declination: 24.10),
        FixedStar(name: "Pollux", type: "Intense", rightAscension: 116.32, declination: 28.02),
        FixedStar(name: "Castor", type: "Intense", rightAscension: 113.64, declination: 31.88),
        
        FixedStar(name: "Zubenelgenubi", type: "Crossroad", rightAscension: 222.71, declination: -16.04),
        FixedStar(name: "Zubeneschamali", type: "Crossroad", rightAscension: 229.25, declination: -9.38),
        FixedStar(name: "Alphard", type: "Crossroad", rightAscension: 141.89, declination: -8.65),
        FixedStar(name: "Denebola", type: "Crossroad", rightAscension: 177.26, declination: 14.57),
        FixedStar(name: "Vindemiatrix", type: "Crossroad", rightAscension: 195.53, declination: 10.95),
        
        FixedStar(name: "Acumen", type: "Karma", rightAscension: 266.31, declination: -39.02),
        FixedStar(name: "Aculeus", type: "Karma", rightAscension: 268.21, declination: -39.01),
        FixedStar(name: "Facies", type: "Karma", rightAscension: 284.66, declination: -22.56),
        FixedStar(name: "Menkar", type: "Karma", rightAscension: 45.56, declination: 4.08),
        FixedStar(name: "Mirach", type: "Karma", rightAscension: 17.43, declination: 35.62),
        FixedStar(name: "Alpheratz", type: "Karma", rightAscension: 2.09, declination: 29.09)
    ]
    
    // Light Edition subset
    public static let lightStars: [FixedStar] = [
        proStars[0], proStars[1], proStars[2], proStars[3], // 4 Royals
        proStars[4], proStars[6], proStars[7], proStars[8], proStars[13], // 5 Intense
        proStars[19], proStars[20], proStars[21], proStars[22], proStars[23], // 5 Crossroads
        proStars[24], proStars[25], proStars[26], proStars[27], proStars[28], // 5 Karma
        FixedStar(name: "Galactic Center", type: "None", rightAscension: 266.41, declination: -29.00) // Fallback
    ]
}
