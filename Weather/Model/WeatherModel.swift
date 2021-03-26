//
//  WeatherModel.swift
//  Weather
//
//  Created by Adam Young on 24/02/2021.
//

import Combine
import CoreLocation
import WeatherCore
import SwiftUI

final class WeatherModel: ObservableObject {
   
    @Published private(set) var localPlace = Place.london
    @Published private(set) var places = [Place.london, Place.nottingham]
    @Published private(set) var weatherResults: [Place.ID: Weather] = [:]
    
    @Published var placeSearchQuery = ""
    @Published private(set) var placeResults: [Place] = []
    
    private let weatherManager: WeatherManaging
    private let locationProvider = LocationProvider()
    private var cancellables = Set<AnyCancellable>()

    init(weatherManager: WeatherManaging = WeatherManager(apiKey: "cd44b938f1abdc127233c40ae93ca7e1")) {
        self.weatherManager = weatherManager
        
        $placeSearchQuery
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .flatMap { query -> AnyPublisher<[Place], Never> in
                if query.isEmpty {
                    return Just([])
                        .eraseToAnyPublisher()
                }

                return weatherManager.placesPublisher(query: query)
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.placeResults, on: self)
            .store(in: &cancellables)
        
        listenForLocationChanges()
    }
    
    func fetchLocalWeather() {
        weatherManager.weatherPublisher(forCity: localPlace.name)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .finished:
                    print("Done")
                
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] weather in
                self?.weatherResults[weather.id] = weather
            }
            .store(in: &cancellables)
    }
    
    func fetchOtherWeather() {
        places.map(\.id)
            .forEach(fetchWeather)
    }
    
    func add(place: Place) {
        places.append(place)
        fetchOtherWeather()
    }
    
    func movePlace(from source: IndexSet, to destination: Int) {
        places.move(fromOffsets: source, toOffset: destination)
    }
    
    func remove(place: Place) {
        print(places)
        places.removeAll { $0.id == place.id }
        weatherResults.removeValue(forKey: place.id)
    }
    
}

extension WeatherModel {
 
    private func listenForLocationChanges() {
        try? locationProvider.start()
        locationProvider.$location
            .filter { $0 != nil }
            .map { $0! }
            .flatMap { location in
                return self.weatherManager.placePublisher(atLatitude: location.coordinate.latitude,
                                                          longitude: location.coordinate.longitude)
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [weak self] place in
                self?.localPlace = place
                self?.fetchLocalWeather()
            }
            .store(in: &cancellables)
    }
    
}

extension WeatherModel {
    
    private func fetchWeather(forPlace placeID: Place.ID) {
        weatherManager.weatherPublisher(forCityID: placeID)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .finished:
                    print("Done")
                
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] weather in
                self?.weatherResults[placeID] = weather
            }
            .store(in: &cancellables)
    }
    
}
