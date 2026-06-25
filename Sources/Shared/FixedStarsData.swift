import Foundation

public struct FixedStar {
    public let name: String
    public let type: String // "Royal", "Intense", "Crossroad", "Karma"
    public let longitude: Double // Approximation for mock logic until Swiss Ephemeris is linked
    public let orb: Double
    public let meaning: String
}

public class FixedStarsData {
    
    // ==========================================
    // PRO EDITION (30 Stars Strict List)
    // ==========================================
    public static let proStars: [FixedStar] = [
        // The 4 Royal Stars
        FixedStar(name: "Fomalhaut", type: "Royal", longitude: 333.9, orb: 2.0, meaning: "King Star of beauty and solitude."),
        FixedStar(name: "Aldebaran", type: "Royal", longitude: 69.8, orb: 2.0, meaning: "King Star of great integrity and material prosperity."),
        FixedStar(name: "Regulus", type: "Royal", longitude: 149.8, orb: 2.0, meaning: "King Star of absolute authority and noble glory."),
        FixedStar(name: "Antares", type: "Royal", longitude: 249.8, orb: 2.0, meaning: "King Star of conflict, destruction, and rebirth."),
        
        // The 14 Intense Stars
        FixedStar(name: "Algol", type: "Intense", longitude: 56.2, orb: 1.0, meaning: "Demon King - violence and destructive power."),
        FixedStar(name: "Spica", type: "Intense", longitude: 203.8, orb: 1.0, meaning: "Heavenly benevolence and sacred genius."),
        FixedStar(name: "Sirius", type: "Intense", longitude: 104.1, orb: 1.0, meaning: "Absolute ambition and supreme honor."),
        FixedStar(name: "Procyon", type: "Intense", longitude: 115.8, orb: 1.0, meaning: "Swift incisiveness and transient victory."),
        FixedStar(name: "Betelgeuse", type: "Intense", longitude: 88.8, orb: 1.0, meaning: "Immense honor and triumph."),
        FixedStar(name: "Rigel", type: "Intense", longitude: 76.8, orb: 1.0, meaning: "Unyielding wisdom and guidance."),
        FixedStar(name: "Canopus", type: "Intense", longitude: 104.9, orb: 1.0, meaning: "Profound wisdom and eternal navigation."),
        FixedStar(name: "Capella", type: "Intense", longitude: 81.8, orb: 1.0, meaning: "Absolute independence and freedom."),
        FixedStar(name: "Vega", type: "Intense", longitude: 285.3, orb: 1.0, meaning: "Supreme artistry and mesmerizing charisma."),
        FixedStar(name: "Altair", type: "Intense", longitude: 301.8, orb: 1.0, meaning: "Unyielding courage and lofty flight."),
        FixedStar(name: "Deneb", type: "Intense", longitude: 305.3, orb: 1.0, meaning: "Far-reaching intellect and imperishable inquiry."),
        FixedStar(name: "Arcturus", type: "Intense", longitude: 204.2, orb: 1.0, meaning: "Vanguard star of transformation."),
        FixedStar(name: "Achernar", type: "Intense", longitude: 351.6, orb: 1.0, meaning: "Lofty spirituality and ultimate salvation."),
        FixedStar(name: "Pollux", type: "Intense", longitude: 113.2, orb: 1.0, meaning: "Cold insight and unyielding struggle."),
        
        // 12 More stars to make 30
        FixedStar(name: "Castor", type: "Intense", longitude: 110.2, orb: 1.0, meaning: "Sharp intellect and duality."),
        FixedStar(name: "Bellatrix", type: "Intense", longitude: 81.0, orb: 1.0, meaning: "Female warrior - fighting for one's rights."),
        FixedStar(name: "Markab", type: "Intense", longitude: 353.4, orb: 1.0, meaning: "Solid foundational skills and sorrow."),
        FixedStar(name: "Scheat", type: "Intense", longitude: 359.2, orb: 1.0, meaning: "Genius thinking or intellect gone wild."),
        FixedStar(name: "Algenib", type: "Intense", longitude: 9.1, orb: 1.0, meaning: "Strong will and penetrating mind."),
        FixedStar(name: "Mirach", type: "Crossroad", longitude: 30.4, orb: 1.0, meaning: "Receptivity, beauty, love."),
        FixedStar(name: "Polaris", type: "Crossroad", longitude: 88.5, orb: 1.0, meaning: "The pole star, unshakeable axis."),
        FixedStar(name: "Alcyone", type: "Crossroad", longitude: 59.9, orb: 1.0, meaning: "Mysticism, inner vision."),
        FixedStar(name: "Acrux", type: "Crossroad", longitude: 221.9, orb: 1.0, meaning: "Intuition, mystical trials."),
        FixedStar(name: "Menkar", type: "Karma", longitude: 44.3, orb: 1.0, meaning: "Waves of change from collective unconscious."),
        FixedStar(name: "Zosma", type: "Karma", longitude: 161.3, orb: 1.0, meaning: "Victimhood, bearing others' pain."),
        FixedStar(name: "Denebola", type: "Karma", longitude: 171.6, orb: 1.0, meaning: "The outsider deviating from the mainstream.")
    ]
    
    // ==========================================
    // LIGHT EDITION (20 Stars Strict List)
    // ==========================================
    public static let lightStars: [FixedStar] = Array(proStars.prefix(20)) // Mock implementation using first 20
    
    // Fallback for NONE results in Light Edition
    public static let galacticCenter = FixedStar(
        name: "Galactic Center",
        type: "Void",
        longitude: 267.0, // 27 Sagittarius
        orb: 2.0,
        meaning: "The star that locks thy soul exists nowhere in the firmament. Thou belongest to no faction of the gods; thou art a person of the absolute Void."
    )
}
