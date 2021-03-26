import CoreLocation
import Foundation

public struct Place: Identifiable, Codable {
    
    public let id: Int
    public let name: String
    public let countryCode: String
    public let coordinate: CLLocationCoordinate2D
    
    public var formattedName: String {
        "\(name), \(countryCode)"
    }
    
    public init(id: Int, name: String, countryCode: String, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.name = name
        self.countryCode = countryCode
        self.coordinate = coordinate
    }
    
}

//extension Place: RawRepresentable {
//
//    public init?(rawValue: String) {
//        guard let data = rawValue.data(using: .utf8),
//              let result = try? JSONDecoder().decode(Place.self, from: data)
//        else {
//            return nil
//        }
//
//        self = result
//    }
//
//    public var rawValue: String {
//        guard let data = try? JSONEncoder().encode(self),
//              let result = String(data: data, encoding: .utf8)
//        else {
//            return ""
//        }
//
//        return result
//    }
//
//}

extension Place {
    
    public static var london: Place {
        let coordinate = CLLocationCoordinate2D(latitude: -0.1257, longitude: 51.5085)
        return Place(id: 2643743, name: "London", countryCode: "GB", coordinate: coordinate)
    }
    
    public static var nottingham: Place {
        let coordinate = CLLocationCoordinate2D(latitude: -1.1505, longitude: 52.9536)
        return Place(id: 2641170, name: "Nottingham", countryCode: "GB", coordinate: coordinate)
    }
    
}

extension Array: RawRepresentable where Element == Place {
    
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        
        self = result
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        
        return result
    }
    
}
