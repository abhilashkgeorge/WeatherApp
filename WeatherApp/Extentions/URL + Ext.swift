//
//  URL + Ext.swift
//  WeatherApp
//
//  Created by Abhilash k George on 20/03/22.
//

import Foundation

  
extension URL {
   
   static let baseURL = "https://api.openweathermap.org/data/2.5/weather"
   static let APIKey = "5ea7139e9797a5d9d28a0b895063e7a5"
   
   static func getWeatherByCity(city: String) -> String {
       let weatherRequestURL = "\(URL.baseURL)?q=\(city)&APPID=\(URL.APIKey)"
       
     //  guard let url = URL(string: weatherRequestURL) else { fatalError() }
       return weatherRequestURL
       
   }
   
   static func getWeatherByCoordinates(latitude: Double, longitude: Double) -> String {
       let weatherRequestURL = "\(URL.baseURL)?APPID=\(URL.APIKey)&lat=\(latitude)&lon=\(longitude)"
       
      // guard let url = URL(string: weatherRequestURL) else { fatalError() }
       return weatherRequestURL
       
   }

   
   
   
   
   
}
