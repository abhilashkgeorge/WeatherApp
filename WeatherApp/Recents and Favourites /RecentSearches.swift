//
//  RecentSearches.swift
//  WeatherApp
//
//  Created by Abhilash k George on 06/03/22.
//

import Foundation
import UIKit

public struct RecentSearches {
    
    var location: String 
    var currentTemperature: Double
    var weatherIcon: UIImage
    var weatherStatus: String
    var isFavourite: Bool

    
    init(location: String, currentTemperature: Double, weatherIcon: UIImage, weatherStatus: String, isFavourite: Bool) {
        self.location = location
        self.currentTemperature = currentTemperature
        self.weatherIcon = weatherIcon
        self.weatherStatus = weatherStatus
        self.isFavourite = isFavourite
    }

}

