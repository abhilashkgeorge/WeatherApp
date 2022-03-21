//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Abhilash k George on 23/02/22.
//

import UIKit

struct WeatherModel  {
    
    var coord: Coord
    var weather: [Weather]
    var base: String
    var main: Main
    var visibility: Int
    var wind: Wind
    var clouds: Clouds
    var dt: Int
    var sys: Sys
    var timezone: Int
    var id: Int
    var name: String
}

struct Weather: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Coord: Decodable {
    var lon: Double
    var lat: Double
}

struct Wind: Decodable {
    var speed: Double
    var deg: Double
}

struct Main: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var humidity:Int
}
struct Clouds: Decodable {
    var all: Int
}

struct Sys: Decodable {
    var type: Int
    var id: Int
    var country: String
    var sunrise: Int
    var sunset: Int

}
