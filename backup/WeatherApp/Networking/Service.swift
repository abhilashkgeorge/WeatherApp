//
//  Service.swift
//  WeatherApp
//
//  Created by Abhilash k George on 23/02/22.
//

import Foundation
import UIKit

class Service :NSObject {
    func getImageFromString(imageCode: String)
    -> UIImage {
        
        let image: UIImage = UIImage(named: "icon_precipitation_info")!
        
        let imageUrl = "http://openweathermap.org/img/w/" + imageCode + ".png"

       // let url = URL(fileURLWithPath: imageUrl) #
        return image
    }
}
