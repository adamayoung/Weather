import CoreLocation
import Foundation
import OpenWeather

extension Weather {
    
    init(dto: WeatherDTO) {
        let place = Place(dto: dto.place)
        let conditions = dto.conditions.map(Condition.init)
        let wind = WindMeasurement(dto: dto.wind)
        let rainfall = PrecipitationMeasurement(dto: dto.rainfall)
        let snowfall = PrecipitationMeasurement(dto: dto.snowfall)

        self.init(place: place, timeZone: dto.timeZone, conditions: conditions, temperature: dto.temperature,
                  feelsLikeTemperature: dto.feelsLikeTemperature, maximumTemperature: dto.maximumTemperature,
                  minimumTemperature: dto.minimumTemperature, pressure: dto.pressure,
                  seaLevelPressure: dto.seaLevelPressure, groundLevelPressure: dto.groundLevelPressure,
                  humidity: dto.humidity, visibility: dto.visibility, wind: wind, cloudiness: dto.cloudiness,
                  rainfall: rainfall, snowfall: snowfall, timestamp: dto.timestamp)
    }
    
}
