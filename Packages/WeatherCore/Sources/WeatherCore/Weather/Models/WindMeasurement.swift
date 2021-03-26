import CoreLocation
import Foundation

public struct WindMeasurement: Codable {

    public let speed: Measurement<UnitSpeed>
    public let direction: CLLocationDirection
    public let gustSpeed: Measurement<UnitSpeed>?

}

extension WindMeasurement {
    
    public static var data: WindMeasurement {
        let speed = Measurement(value: 6.69, unit: UnitSpeed.metersPerSecond)
        let direction = CLLocationDirection(80.0)
        
        return WindMeasurement(speed: speed, direction: direction, gustSpeed: nil)
    }
    
}
