//
//  CurrentLocation.swift
//  WeatherApp
//
//  Created by Abhilash k George on 23/02/22.
//

import UIKit
import CoreLocation

class Location: NSObject, CLLocationManagerDelegate {
    
    static let shareInstance = Location()
    let apiManager = APIManager()
    var locationManager: CLLocationManager!
    var completion:  ((CLLocation) -> Void)?
    
    func configureCurrentLocation(completion: @escaping ((CLLocation) -> Void)) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                DispatchQueue.global(qos: .background).async { [weak self] in
                    self?.locationManager.startUpdatingLocation()
                }
            default:
                // handle case where authorization has not been granted yet
                break
            }
            
            self.completion = completion
        }
    }

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            DispatchQueue.global(qos: .background).async { [weak self] in
                self?.locationManager.startUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        completion?(location)
        locationManager.stopUpdatingLocation()
    }
}
