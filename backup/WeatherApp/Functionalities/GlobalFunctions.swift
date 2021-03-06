////
////  GlobalFunctions.swift
////  WeatherApp
////
////  Created by Abhilash k George on 28/02/22.

import Foundation
import CoreLocation
import UIKit
//

class GlobalFunctions {
  
    func convertKelvinToCelsius(value: Double) -> String {
        let celsius = value - 273.15
        let result = Int(celsius)
        return "\(result)"
    }
    
    func convertKelvinToFahrenheit(value: Double) -> String {
        let fahrenheit = (value - 273.15) * 9 / 5 + 32
        let result = Int(fahrenheit)
        return "\(result)"
    }
    
    
}
