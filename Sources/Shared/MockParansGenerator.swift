import Foundation

/// Generates mock Parans data for the prototype until the full ephemeris API is connected.
/// Uses a seed to ensure the same person always gets the same results.
public class MockParansGenerator {
    
    public static func generatePlanetParans(seed: String) -> [(planet: String, angle1: String, star: String, angle2: String, orb: String)] {
        var rng = seededGenerator(from: seed)
        let planets = ["Sun", "Moon", "Mercury", "Venus", "Mars", "Jupiter", "Saturn"]
        let angles = ["ASC", "MC", "DSC", "IC"]
        let stars = FixedStarsData.proStars.map { $0.name }
        
        let count = Int.random(in: 2...5, using: &rng)
        var results: [(String, String, String, String, String)] = []
        
        for _ in 0..<count {
            let p = planets.randomElement(using: &rng)!
            let a1 = angles.randomElement(using: &rng)!
            let s = stars.randomElement(using: &rng)!
            let a2 = angles.randomElement(using: &rng)!
            let orb = String(format: "0°%02d'", Int.random(in: 0...59, using: &rng))
            
            results.append((p, a1, s, a2, orb))
        }
        return results
    }
    
    public static func generateAxisParans(seed: String) -> [(axis: String, star: String, orb: String)] {
        var rng = seededGenerator(from: seed + "axis")
        let angles = ["ASC", "MC", "DSC", "IC"]
        let stars = FixedStarsData.proStars.map { $0.name }
        
        let count = Int.random(in: 1...3, using: &rng)
        var results: [(String, String, String)] = []
        
        for _ in 0..<count {
            let a = angles.randomElement(using: &rng)!
            let s = stars.randomElement(using: &rng)!
            let orb = String(format: "0°%02d'", Int.random(in: 0...30, using: &rng))
            results.append((a, s, orb))
        }
        return results
    }
    
    private static func seededGenerator(from string: String) -> SeededRandomNumberGenerator {
        let seed = string.utf8.reduce(0) { $0 &+ UInt64($1) }
        return SeededRandomNumberGenerator(seed: seed)
    }
}

struct SeededRandomNumberGenerator: RandomNumberGenerator {
    private var state: UInt64
    
    init(seed: UInt64) {
        self.state = seed == 0 ? 1 : seed
    }
    
    mutating func next() -> UInt64 {
        state ^= state &<< 13
        state ^= state &>> 7
        state ^= state &<< 17
        return state
    }
}
