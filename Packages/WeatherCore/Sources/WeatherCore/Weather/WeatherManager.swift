import Combine
import Foundation
import OpenWeather

public protocol WeatherManaging {
    
    /// Fetch weather for a city or town by location name.
    ///
    /// - Parameters:
    ///   - cityName: Name of city or name to fetch weather for.
    ///
    /// - Returns: A publisher containing the weather.
    func weatherPublisher(forCity cityName: String) -> AnyPublisher<Weather, OpenWeatherError>
    
    /// Fetch weather for a city or town by ID.
    ///
    /// - Parameters:
    ///   - cityID: Identifier of city to fetch weather for.
    ///
    /// - Returns: A publisher containing the weather.
    func weatherPublisher(forCityID cityID: Int) -> AnyPublisher<Weather, OpenWeatherError>
    
    /// Fetch weather for a city or town by geographic coordinates.
    ///
    /// - Parameters:
    ///   - latitude: Latitude.
    ///   - longitude: Longitude.
    ///
    /// - Returns: A publisher containing the weather.
    func weatherPublisher(forLatitude latitude: Double, longitude: Double) -> AnyPublisher<Weather, OpenWeatherError>
    
    /// Search for places.
    ///
    /// - Parameters:
    ///   - query: The place to search for.
    ///
    /// - Returns: A publisher containing the matching places.
    func placesPublisher(query: String) -> AnyPublisher<[Place], Never>
    
    /// Place at geographic coordinates.
    ///
    /// - Parameters:
    ///   - latitude: Latitude.
    ///   - longitude: Longitude.
    ///
    /// - Returns: A publisher containing the place.
    func placePublisher(atLatitude latitude: Double, longitude: Double) -> AnyPublisher<Place, OpenWeatherError>
    
}

public final class WeatherManager: WeatherManaging {
    
    private let weatherService: WeatherService
    
    public convenience init(apiKey: String) {
        self.init(weatherService: OpenWeatherService(apiKey: apiKey))
    }
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    public func weatherPublisher(forCity cityName: String) -> AnyPublisher<Weather, OpenWeatherError> {
        weatherService.weatherPublisher(forCity: cityName)
            .map(Weather.init)
            .eraseToAnyPublisher()
    }
    
    public func weatherPublisher(forCityID cityID: Int) -> AnyPublisher<Weather, OpenWeatherError> {
        weatherService.weatherPublisher(forCityID: cityID)
            .map(Weather.init)
            .eraseToAnyPublisher()
    }
    
    public func weatherPublisher(forLatitude latitude: Double,
                                 longitude: Double) -> AnyPublisher<Weather, OpenWeatherError> {
        weatherService.weatherPublisher(forLatitude: latitude, longitude: longitude)
            .map(Weather.init)
            .eraseToAnyPublisher()
    }
    
    public func placesPublisher(query: String) -> AnyPublisher<[Place], Never> {
        weatherService.placesPublisher(query: query)
            .map(Place.create)
            .eraseToAnyPublisher()
    }
    
    public func placePublisher(atLatitude latitude: Double,
                               longitude: Double) -> AnyPublisher<Place, OpenWeatherError> {
        weatherService.placePublisher(atLatitude: latitude, longitude: longitude)
            .map(Place.init)
            .eraseToAnyPublisher()
    }
    
}
