//
//  CurrentLocation.swift
//  WeatherApp
//
//  Created by Abhilash k George on 23/02/22.
//

import UIKit
import CoreLocation

class Location: NSObject, CLLocationManagerDelegate {
    
   // var service = Service()
    static let shareInstance = Location()
    var locationManager: CLLocationManager!
    
    func configureCurrentLocation() {
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        guard let location = locations.last else { return}
        
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        print(latitude)
        print(longitude)
    
        
    }
    
}

