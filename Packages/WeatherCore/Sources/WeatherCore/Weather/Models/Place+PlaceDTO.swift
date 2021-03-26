import CoreLocation
import Foundation
import OpenWeather

extension Place {
    
    init(dto: PlaceDTO) {
        let coordinate = CLLocationCoordinate2D(latitude: dto.coordinate.latitude, longitude: dto.coordinate.longitude)
        self.init(id: dto.id, name: dto.name, countryCode: dto.countryCode, coordinate: coordinate)
    }
    
    static func create(dtos: [PlaceDTO]) -> [Place] {
        dtos.map(Place.init)
    }
    
}
