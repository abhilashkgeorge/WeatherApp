//
//  UIFont + Ext.swift
//  WeatherApp
//
//  Created by Abhilash k George on 20/03/22.
//

import Foundation
import UIKit

extension UIFont {
    
    func robotoRegular(with size: CGFloat) ->  UIFont{
        return UIFont(name: "Roboto-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
