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
    
    // MARK: - Sun Position (Approximation for Parans)
    /// Returns the Right Ascension and Declination of the Sun for a given Date.
    public func sunPosition(for date: Date) -> (ra: Double, dec: Double) {
        let jd = julianDay(from: date)
        let d = jd - 2451545.0 // Days since J2000.0
        
        // Mean anomaly of the Sun
        let g = (357.529 + 0.98560028 * d).normalizedDegrees()
        // Mean longitude of the Sun
        let q = (280.459 + 0.98564736 * d).normalizedDegrees()
        
        // Ecliptic longitude of the Sun
        let l = (q + 1.915 * sin(g * deg2rad) + 0.020 * sin(2 * g * deg2rad)).normalizedDegrees()
        
        // Obliquity of the ecliptic
        let e = 23.439 - 0.00000036 * d
        
        // Right Ascension
        var ra = atan2(cos(e * deg2rad) * sin(l * deg2rad), cos(l * deg2rad)) * rad2deg
        ra = ra.normalizedDegrees()
        
        // Declination
        let dec = asin(sin(e * deg2rad) * sin(l * deg2rad)) * rad2deg
        
        return (ra, dec)
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
        let od = (ra + ad).normalizedDegrees()
        
        return (oa, od)
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
}
