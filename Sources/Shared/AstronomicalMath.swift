import Foundation

/// Provides Pure Swift astronomical calculations for the Sun's position
/// and Oblique Ascension (OA) / Oblique Descension (OD) for Parans.
public class AstronomicalMath {
    
    public static let shared = AstronomicalMath()
    
    private let deg2rad = Double.pi / 180.0
    private let rad2deg = 180.0 / Double.pi
    
    // MARK: - Julian Day
    public func julianDay(from date: Date) -> Double {
        return date.timeIntervalSince1970 / 86400.0 + 2440587.5
    }
    
    // MARK: - Sun Position (True Celestial Engine)
    /// Returns the Right Ascension and Declination of the Sun for a given Date.
    public func sunPosition(for date: Date) -> (ra: Double, dec: Double) {
        let jd = julianDay(from: date)
        // SE_SUN = 0
        return SwephWrapper.shared.calculatePlanetPosition(julianDay: jd, planetId: 0)
    }
    
    // MARK: - Oblique Ascension / Descension
    public func computeOA_OD(ra: Double, dec: Double, lat: Double) -> (oa: Double, od: Double)? {
        let decRad = dec * deg2rad
        let latRad = lat * deg2rad
        
        let sinAD = tan(decRad) * tan(latRad)
        
        // Check if circumpolar (never sets or never rises)
        if abs(sinAD) > 1.0 {
            return nil // Star is circumpolar at this latitude
        }
        
        let ad = asin(sinAD) * rad2deg
        
        let oa = (ra - ad).normalizedDegrees()
        let od = (ra + ad + 180.0).normalizedDegrees() // Corrected OD formula: RA + AD + 180
        
        return (oa, od)
    }
    
    // MARK: - LST of Angles
    /// Calculates the Local Sidereal Time (LST) when a body crosses the 4 major angles.
    public func computeLSTAngles(ra: Double, dec: Double, lat: Double) -> [String: Double]? {
        guard let oaOd = computeOA_OD(ra: ra, dec: dec, lat: lat) else {
            return nil // Circumpolar
        }
        return [
            "ASC": oaOd.oa,
            "DSC": oaOd.od,
            "MC": ra.normalizedDegrees(),
            "IC": (ra + 180.0).normalizedDegrees()
        ]
    }
    
    // MARK: - Heliacal Rising Star
    /// Finds the star that rises just before the Sun.
    public func calculateHeliacalRisingStar(for date: Date, latitude: Double, stars: [FixedStar]) -> FixedStar? {
        let sunPos = sunPosition(for: date)
        guard let sunOA_OD = computeOA_OD(ra: sunPos.ra, dec: sunPos.dec, lat: latitude) else {
            return nil
        }
        
        let sunOA = sunOA_OD.oa
        
        var bestStar: FixedStar? = nil
        var minDiff = Double.greatestFiniteMagnitude
        
        for star in stars {
            guard let starOA_OD = computeOA_OD(ra: star.rightAscension, dec: star.declination, lat: latitude) else {
                continue // Skip circumpolar stars
            }
            
            let starOA = starOA_OD.oa
            
            // The star must rise BEFORE the sun. 
            // So starOA should be less than sunOA.
            // We calculate the angular difference going backwards from Sun to Star.
            var diff = sunOA - starOA
            if diff < 0 { diff += 360.0 }
            
            // We want the star with the smallest positive difference (closest to rising before the sun)
            if diff < minDiff {
                minDiff = diff
                bestStar = star
            }
        }
        
        return bestStar
    }

    // MARK: - Heliacal Setting Star
    /// Finds the star that sets just before the Sun rises (Cosmic Setting).
    public func calculateHeliacalSettingStar(for date: Date, latitude: Double, stars: [FixedStar]) -> FixedStar? {
        let sunPos = sunPosition(for: date)
        guard let sunOA_OD = computeOA_OD(ra: sunPos.ra, dec: sunPos.dec, lat: latitude) else {
            return nil
        }
        
        // Dawn is when the Sun is rising (Sun's Oblique Ascension)
        let sunOA = sunOA_OD.oa
        
        var bestStar: FixedStar? = nil
        var minDiff = Double.greatestFiniteMagnitude
        
        for star in stars {
            guard let starOA_OD = computeOA_OD(ra: star.rightAscension, dec: star.declination, lat: latitude) else {
                continue // Skip circumpolar stars
            }
            
            // The star must set (OD) BEFORE the sun rises (OA).
            let starOD = starOA_OD.od
            
            var diff = sunOA - starOD
            if diff < 0 { diff += 360.0 }
            
            // We want the star with the smallest positive difference
            if diff < minDiff {
                minDiff = diff
                bestStar = star
            }
        }
        
        return bestStar
    }

    // MARK: - Full Parans Calculation (True Engine)
    /// Calculates all valid Parans (Planet-Star and Axis-Star) for a given birth moment.
    public func calculateAllParans(date: Date, latitude: Double, longitude: Double, stars: [FixedStar]) 
    -> (planetParans: [(String, String, String, String, String)], axisParans: [(String, String, String)]) {
        
        let jd = julianDay(from: date)
        
        // 1. Calculate Birth LST (Local Sidereal Time)
        // GST is returned in hours (0-24), convert to degrees (0-360)
        let gstHours = SwephWrapper.shared.getGreenwichSiderealTime(julianDay: jd)
        let gstDegrees = gstHours * 15.0
        let birthLST = (gstDegrees + longitude).normalizedDegrees()
        
        // Setup angle coordinates for the birth moment
        let birthAngles: [String: Double] = [
            "MC": birthLST,
            "IC": (birthLST + 180.0).normalizedDegrees(),
            // For true ASC/DSC LST, we use the latitude.
            // However, Axis Parans conceptually mean "Star is on Angle exactly at Birth LST".
            // So a Star is on the MC if Star's RA == birthLST.
            // A star is on the ASC if Star's OA == birthLST.
            "ASC": birthLST,
            "DSC": birthLST
        ]
        
        var pParans: [(String, String, String, String, String)] = []
        var aParans: [(String, String, String)] = []
        
        let planets: [(name: String, id: Int32)] = [
            ("Sun", 0), ("Moon", 1), ("Mercury", 2), ("Venus", 3), 
            ("Mars", 4), ("Jupiter", 5), ("Saturn", 6)
        ]
        
        let orbDeg = 1.0 // 1 degree standard orb for parans
        
        // Pre-calculate Planet Angles
        var planetAnglesMap: [String: [String: Double]] = [:]
        for planet in planets {
            let pos = SwephWrapper.shared.calculatePlanetPosition(julianDay: jd, planetId: planet.id)
            if let angles = computeLSTAngles(ra: pos.ra, dec: pos.dec, lat: latitude) {
                planetAnglesMap[planet.name] = angles
            }
        }
        
        // Compare with Stars
        for star in stars {
            guard let starAngles = computeLSTAngles(ra: star.rightAscension, dec: star.declination, lat: latitude) else {
                continue // Skip circumpolar stars
            }
            
            // Axis Parans Check
            for (angleName, starLST) in starAngles {
                let diff = abs(starLST - birthAngles[angleName]!)
                let wrappedDiff = min(diff, 360.0 - diff)
                if wrappedDiff <= orbDeg {
                    let orbStr = String(format: "0°%02d'", Int(wrappedDiff * 60))
                    aParans.append((angleName, star.name, orbStr))
                }
            }
            
            // Planet Parans Check
            for (planetName, pAngles) in planetAnglesMap {
                for (pAngleName, pLST) in pAngles {
                    for (sAngleName, sLST) in starAngles {
                        let diff = abs(pLST - sLST)
                        let wrappedDiff = min(diff, 360.0 - diff)
                        if wrappedDiff <= orbDeg {
                            let orbStr = String(format: "0°%02d'", Int(wrappedDiff * 60))
                            pParans.append((planetName, pAngleName, star.name, sAngleName, orbStr))
                        }
                    }
                }
            }
        }
        let planetOrder: [String: Int] = [
            "Sun": 0, "Moon": 1, "Mercury": 2, "Venus": 3, 
            "Mars": 4, "Jupiter": 5, "Saturn": 6
        ]
        
        pParans.sort {
            let order0 = planetOrder[$0.0] ?? 99
            let order1 = planetOrder[$1.0] ?? 99
            if order0 != order1 {
                return order0 < order1
            }
            return $0.4 < $1.4 // orbStr
        }
        
        let axisOrder: [String: Int] = ["ASC": 0, "MC": 1, "DSC": 2, "IC": 3]
        aParans.sort {
            let order0 = axisOrder[$0.0] ?? 99
            let order1 = axisOrder[$1.0] ?? 99
            if order0 != order1 {
                return order0 < order1
            }
            return $0.2 < $1.2 // orbStr
        }
        
        return (pParans, aParans)
    }
}

extension Double {
    func normalizedDegrees() -> Double {
        var res = self.truncatingRemainder(dividingBy: 360.0)
        if res < 0 { res += 360.0 }
        return res
    }
}

