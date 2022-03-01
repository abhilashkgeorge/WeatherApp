//
//  Service.swift
//  WeatherApp
//
//  Created by Abhilash k George on 23/02/22.
//

import Foundation
import UIKit

enum Urls: String{
    
    case url  = "https://api.openweathermap.org/data/2.5/weather?q=Bangalore&APPID=5ea7139e9797a5d9d28a0b895063e7a5"
    
    case urlLatLon = "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&APPID=5ea7139e9797a5d9d28a0b895063e7a5"
}


class Service :NSObject {
    func getImageFromString(value: String, weatherModel: WeatherModel) -> UIImage {
        
       
        
        let image: UIImage = UIImage(named: "icon_precipitation_info")!
        
        guard let imageString = weatherModel.weather.last?.icon else{ return image
        }
        let imageUrl = "http://openweathermap.org/img/w/" + imageString + ".png"
        guard let url = URL(string: imageUrl) else { return  image}
       // let url = URL(fileURLWithPath: imageUrl) #
        return image
    }
}



