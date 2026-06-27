import Foundation

/// A database of major world cities for the Solar Return Relocation Bulk Calculator.
public struct WorldCity {
    public let name: String
    public let country: String
    public let latitude: Double
    public let longitude: Double
    
    public var displayName: String {
        return "\(name), \(country)"
    }
}

public struct WorldCitiesData {
    public static let cities: [WorldCity] = [
        // Asia
        WorldCity(name: "Tokyo", country: "Japan", latitude: 35.6762, longitude: 139.6503),
        WorldCity(name: "Kyoto", country: "Japan", latitude: 35.0116, longitude: 135.7680),
        WorldCity(name: "Seoul", country: "South Korea", latitude: 37.5665, longitude: 126.9780),
        WorldCity(name: "Beijing", country: "China", latitude: 39.9042, longitude: 116.4074),
        WorldCity(name: "Shanghai", country: "China", latitude: 31.2304, longitude: 121.4737),
        WorldCity(name: "Hong Kong", country: "China", latitude: 22.3193, longitude: 114.1694),
        WorldCity(name: "Taipei", country: "Taiwan", latitude: 25.0330, longitude: 121.5654),
        WorldCity(name: "Singapore", country: "Singapore", latitude: 1.3521, longitude: 103.8198),
        WorldCity(name: "Bangkok", country: "Thailand", latitude: 13.7563, longitude: 100.5018),
        WorldCity(name: "Manila", country: "Philippines", latitude: 14.5995, longitude: 120.9842),
        WorldCity(name: "Jakarta", country: "Indonesia", latitude: -6.2088, longitude: 106.8456),
        WorldCity(name: "Kuala Lumpur", country: "Malaysia", latitude: 3.1390, longitude: 101.6869),
        WorldCity(name: "New Delhi", country: "India", latitude: 28.6139, longitude: 77.2090),
        WorldCity(name: "Mumbai", country: "India", latitude: 19.0760, longitude: 72.8777),
        WorldCity(name: "Dubai", country: "UAE", latitude: 25.2048, longitude: 55.2708),
        
        // Europe
        WorldCity(name: "London", country: "UK", latitude: 51.5074, longitude: -0.1278),
        WorldCity(name: "Paris", country: "France", latitude: 48.8566, longitude: 2.3522),
        WorldCity(name: "Berlin", country: "Germany", latitude: 52.5200, longitude: 13.4050),
        WorldCity(name: "Rome", country: "Italy", latitude: 41.9028, longitude: 12.4964),
        WorldCity(name: "Madrid", country: "Spain", latitude: 40.4168, longitude: -3.7038),
        WorldCity(name: "Amsterdam", country: "Netherlands", latitude: 52.3676, longitude: 4.9041),
        WorldCity(name: "Vienna", country: "Austria", latitude: 48.2082, longitude: 16.3738),
        WorldCity(name: "Zurich", country: "Switzerland", latitude: 47.3769, longitude: 8.5417),
        WorldCity(name: "Stockholm", country: "Sweden", latitude: 59.3293, longitude: 18.0686),
        WorldCity(name: "Moscow", country: "Russia", latitude: 55.7558, longitude: 37.6173),
        WorldCity(name: "Istanbul", country: "Turkey", latitude: 41.0082, longitude: 28.9784),
        
        // North America
        WorldCity(name: "New York", country: "USA", latitude: 40.7128, longitude: -74.0060),
        WorldCity(name: "Los Angeles", country: "USA", latitude: 34.0522, longitude: -118.2437),
        WorldCity(name: "Chicago", country: "USA", latitude: 41.8781, longitude: -87.6298),
        WorldCity(name: "Miami", country: "USA", latitude: 25.7617, longitude: -80.1918),
        WorldCity(name: "San Francisco", country: "USA", latitude: 37.7749, longitude: -122.4194),
        WorldCity(name: "Seattle", country: "USA", latitude: 47.6062, longitude: -122.3321),
        WorldCity(name: "Honolulu", country: "USA", latitude: 21.3069, longitude: -157.8583),
        WorldCity(name: "Toronto", country: "Canada", latitude: 43.6510, longitude: -79.3470),
        WorldCity(name: "Vancouver", country: "Canada", latitude: 49.2827, longitude: -123.1207),
        WorldCity(name: "Mexico City", country: "Mexico", latitude: 19.4326, longitude: -99.1332),
        
        // South America
        WorldCity(name: "Sao Paulo", country: "Brazil", latitude: -23.5505, longitude: -46.6333),
        WorldCity(name: "Rio de Janeiro", country: "Brazil", latitude: -22.9068, longitude: -43.1729),
        WorldCity(name: "Buenos Aires", country: "Argentina", latitude: -34.6037, longitude: -58.3816),
        WorldCity(name: "Santiago", country: "Chile", latitude: -33.4489, longitude: -70.6693),
        WorldCity(name: "Lima", country: "Peru", latitude: -12.0464, longitude: -77.0428),
        WorldCity(name: "Bogota", country: "Colombia", latitude: 4.7110, longitude: -74.0721),
        
        // Africa
        WorldCity(name: "Cairo", country: "Egypt", latitude: 30.0444, longitude: 31.2357),
        WorldCity(name: "Johannesburg", country: "South Africa", latitude: -26.2041, longitude: 28.0473),
        WorldCity(name: "Cape Town", country: "South Africa", latitude: -33.9249, longitude: 18.4241),
        WorldCity(name: "Lagos", country: "Nigeria", latitude: 6.5244, longitude: 3.3792),
        WorldCity(name: "Nairobi", country: "Kenya", latitude: -1.2864, longitude: 36.8172),
        WorldCity(name: "Casablanca", country: "Morocco", latitude: 33.5731, longitude: -7.5898),
        
        // Oceania
        WorldCity(name: "Sydney", country: "Australia", latitude: -33.8688, longitude: 151.2093),
        WorldCity(name: "Melbourne", country: "Australia", latitude: -37.8136, longitude: 144.9631),
        WorldCity(name: "Brisbane", country: "Australia", latitude: -27.4698, longitude: 153.0251),
        WorldCity(name: "Perth", country: "Australia", latitude: -31.9505, longitude: 115.8605),
        WorldCity(name: "Auckland", country: "New Zealand", latitude: -36.8485, longitude: 174.7633),
        WorldCity(name: "Wellington", country: "New Zealand", latitude: -41.2865, longitude: 174.7762)
    ]
}
