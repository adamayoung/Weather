import Combine
import CoreLocation
import Foundation

public final class LocationProvider: NSObject, ObservableObject {

    @Published public private(set) var location: CLLocation?
    @Published public private(set) var authorizationStatus: CLAuthorizationStatus?
    
    private let locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .other
        locationManager.distanceFilter = 10
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.showsBackgroundLocationIndicator = true
        return locationManager
    }()
    
    public override init() {
        super.init()

        locationManager.delegate = self
    }

    public func requestAuthorization() {
        guard authorizationStatus != .denied else {
            return
        }

        locationManager.requestWhenInUseAuthorization()
    }

    public func start() throws {
        requestAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    public func stop() {
        locationManager.stopUpdatingLocation()
    }
    
}

extension LocationProvider: CLLocationManagerDelegate {

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }

        self.location = location
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let error = error as? CLError else {
            return
        }

        switch error {
        case CLError.denied:
            stop()
            requestAuthorization()

        case CLError.locationUnknown:
            print(#function, "Location manager is unable to retrieve a location.")

        default:
            print(#function, "Location manager failed with unknown CoreLocation error.")
        }
    }

}
