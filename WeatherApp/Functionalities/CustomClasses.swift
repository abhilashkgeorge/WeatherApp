//
//  CustomClasses.swift
//  WeatherApp
//
//  Created by Abhilash k George on 23/02/22.
//

import Foundation
import UIKit

extension UIFont {
    
    func robotoRegular(with size: CGFloat) ->  UIFont{
        return UIFont(name: "Roboto-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

extension UIColor {
    
    func degreeRepresentationRed() -> UIColor {
        return UIColor.red
    }
    
    //rgba(136,81,204,0.68)
    func backgroundColour() -> UIColor {
        return UIColor(red: 136, green: 81, blue: 204, alpha: 0.68)
    }
    
}