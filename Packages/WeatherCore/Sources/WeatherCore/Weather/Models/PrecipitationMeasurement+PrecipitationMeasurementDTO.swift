import Foundation
import OpenWeather

extension PrecipitationMeasurement {
    
    init?(dto: PrecipitationMeasurementDTO?) {
        guard let dto = dto else {
            return nil
        }
        
        self.init(inLastHour: dto.inLastHour, inLastThreeHours: dto.inLastThreeHours)
    }
    
}
