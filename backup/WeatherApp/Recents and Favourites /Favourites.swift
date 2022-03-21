//
//  Favourites.swift
//  WeatherApp
//
//  Created by Abhilash k George on 06/03/22.
//

import Foundation
import UIKit

class Favourites: NSCoding{
    
    required convenience init?(coder: NSCoder) {
        
        guard let location = coder.decodeObject(forKey: "location") as? String,
              let weatherIcon = coder.decodeObject(forKey: "weatherIcon") as? UIImage,
              let currentTemperature = coder.decodeObject(forKey: "currentTemperature") as? String,
              let weatherStatus = coder.decodeObject(forKey: "weatherStatus") as? String
        else {
            return nil
        }
        self.init(location: location, currentTemperature: currentTemperature, weatherIcon: weatherIcon, weatherStatus: weatherStatus)
    }

func encode(with coder: NSCoder) {
    coder.encode(location, forKey: "location")
    coder.encode(weatherIcon, forKey: "weatherIcon")
    coder.encode(currentTemperature, forKey: "currentTemperature")
    coder.encode(weatherStatus, forKey: "weatherStatus")
}


var location: String
var currentTemperature: String
var weatherIcon: UIImage
var weatherStatus: String


init(location: String, currentTemperature: String, weatherIcon: UIImage, weatherStatus: String) {
    self.location = location
    self.currentTemperature = currentTemperature
    self.weatherIcon = weatherIcon
    self.weatherStatus = weatherStatus
}

}
