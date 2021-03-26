import CoreLocation
import Foundation

public struct Weather: Identifiable, Codable {
    
    public var id: Int {
        place.id
    }
    
    public let place: Place
    public let timeZone: TimeZone
    public let conditions: [Condition]
    public let temperature: Measurement<UnitTemperature>
    public let feelsLikeTemperature: Measurement<UnitTemperature>
    public let maximumTemperature: Measurement<UnitTemperature>
    public let minimumTemperature: Measurement<UnitTemperature>
    public let pressure: Measurement<UnitPressure>
    public let seaLevelPressure: Measurement<UnitPressure>?
    public let groundLevelPressure: Measurement<UnitPressure>?
    public let humidity: Double
    public let visibility: Measurement<UnitLength>
    public let wind: WindMeasurement
    public let cloudiness: Double
    public let rainfall: PrecipitationMeasurement?
    public let snowfall: PrecipitationMeasurement?
    public let timestamp: Date
    
}

extension Weather {
    
    public static var londonData: Weather {
        let coordinate = CLLocationCoordinate2D(latitude: -0.1257, longitude: 51.5085)
        let place = Place(id: 2643743, name: "London", countryCode: "GB", coordinate: coordinate)
        let timeZone = TimeZone(secondsFromGMT: 0)!
        let temperature = Measurement(value: 280.61, unit: UnitTemperature.kelvin)
        let feelsLikeTemperature = Measurement(value: 274.69, unit: UnitTemperature.kelvin)
        let maximumTemperature = Measurement(value: 281.48, unit: UnitTemperature.kelvin)
        let minimumTemperature = Measurement(value: 279.82, unit: UnitTemperature.kelvin)
        let pressure = Measurement(value: 279.82, unit: UnitPressure.hectopascals)
        let visibility = Measurement(value: 6000, unit: UnitLength.meters)
        let timestamp = Date(timeIntervalSince1970: 1614596120)
        
        return Weather(place: place, timeZone: timeZone, conditions: [.cloudsData], temperature: temperature,
                feelsLikeTemperature: feelsLikeTemperature, maximumTemperature: maximumTemperature,
                minimumTemperature: minimumTemperature, pressure: pressure, seaLevelPressure: nil,
                groundLevelPressure: nil, humidity: 81, visibility: visibility, wind: .data, cloudiness: 75,
                rainfall: .rainfallData, snowfall: .snowfallData, timestamp: timestamp)
    }
    
}
