//
//  CustomClass.swift
//  WeatherApp
//
//  Created by Abhilash k George on 04/03/22.
//

import Foundation
import UIKit


class CustomClass {
    
    var location: String
    var currentTemperature: Double
    var weatherIcon: String
    var weatherStatus: String
    var isFavourite: Bool = false
    
    init(currentWeatherViewModel: CurrentWeatherViewModel) {
        location = currentWeatherViewModel.country
        currentTemperature = currentWeatherViewModel.currentTemp
        weatherIcon = currentWeatherViewModel.weatherIcon
        weatherStatus = currentWeatherViewModel.status
    }
}
