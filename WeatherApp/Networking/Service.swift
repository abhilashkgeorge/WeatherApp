//
//  Service.swift
//  WeatherApp
//
//  Created by Abhilash k George on 23/02/22.
//

import Foundation
import UIKit

class Service :NSObject {
    func getImageFromString(imageCode: String, weatherModel: WeatherModel)
    -> UIImage {
        
        let image: UIImage = UIImage(named: "icon_precipitation_info")!
        
       // guard let imageString = weatherModel.weather.last?.icon else{ return image
       // }
        let imageUrl = "http://openweathermap.org/img/w/" + imageCode + ".png"

       // let url = URL(fileURLWithPath: imageUrl) #
        return image
    }
}



