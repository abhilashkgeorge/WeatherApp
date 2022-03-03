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
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            self.completion = completion
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) 
    {
    
        guard let location = locations.last else { return}
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        completion?(location)
        locationManager.stopUpdatingLocation()


    }
    
}

