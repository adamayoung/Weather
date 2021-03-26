import CoreLocation
import Foundation
import OpenWeather

extension WindMeasurement {
    
    init(dto: WindMeasurementDTO) {
        let direction = CLLocationDirection(dto.direction.value)
        self.init(speed: dto.speed, direction: direction, gustSpeed: dto.gustSpeed)
    }
    
}
