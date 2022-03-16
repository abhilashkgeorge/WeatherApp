
//  PlaceDetails.swift
//  WeatherApp
//
//  Created by Abhilash k George on 06/03/22.
//

import Foundation
import UIKit

class PlaceDetails: NSObject, NSCoding {
    required convenience init?(coder: NSCoder) {
        
        guard let location = coder.decodeObject(forKey: "location") as? String,
              let weatherIcon = coder.decodeObject(forKey: "weatherIcon") as? UIImage,
              let currentTemperature = coder.decodeObject(forKey: "currentTemperature") as? String,
              let weatherStatus = coder.decodeObject(forKey: "weatherStatus") as? String
           
        else {
            return nil
        }
        let isFavourite = coder.decodeBool(forKey: "isFavourite")
        self.init(location: location, currentTemperature: currentTemperature, weatherIcon: weatherIcon, weatherStatus: weatherStatus, isFavourite: isFavourite)
    }

func encode(with coder: NSCoder) {
    coder.encode(location, forKey: "location")
    coder.encode(weatherIcon, forKey: "weatherIcon")
    coder.encode(currentTemperature, forKey: "currentTemperature")
    coder.encode(weatherStatus, forKey: "weatherStatus")
    coder.encode(isFavourite, forKey: "isFavourite")
}
    
    var location: String
    var currentTemperature: String
    var weatherIcon: UIImage
    var weatherStatus: String
    var isFavourite: Bool

    
    init(location: String, currentTemperature: String, weatherIcon: UIImage, weatherStatus: String, isFavourite: Bool) {
        self.location = location
        self.currentTemperature = currentTemperature
        self.weatherIcon = weatherIcon
        self.weatherStatus = weatherStatus
        self.isFavourite = isFavourite
    }

}

