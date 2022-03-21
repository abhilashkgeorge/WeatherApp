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

extension UIImage {
    
    enum AssetImages: String {
        
        case Sunny = "icon_mostly_sunny_small"
        case FavActive = "icon_favourite_active"
        case FavInactive = "icon_favourite"
        case SearchIcon = "icon_search_white"
        case HamburgerMenu = "icon_menu_white"
        case Logo = "logo_splash"
        
        
    }
}

extension String {
    
    enum Identifiers: String {
        case favouriteViewControllerIdentifier = "favouriteScreenIdentifier"
        case recentsViewControllerIdentifier = "recentsScreenIdentifier"
    }
    
    enum dateFormatter: String {
        case DateFormat = "EEE, dd MMM yyyy hh:mm a"
    }
}

extension UILabel {
    func addCharacterSpacing(spacingValue: Double = 2.0) {
        guard let text = text, !text.isEmpty else { return }
        let string = NSMutableAttributedString(string: text)
        string.addAttribute(NSAttributedString.Key.kern, value: spacingValue, range: NSRange(location: 0, length: string.length - 1))
        attributedText = string
    }
    
    
}
extension URL {
    
    static let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    static let APIKey = "5ea7139e9797a5d9d28a0b895063e7a5"
    
    static func getWeatherByCity(city: String) -> URL {
        let weatherRequestURL = "\(URL.baseURL)?q=\(city)&APPID=\(URL.APIKey)"
        
        guard let url = URL(string: weatherRequestURL) else { fatalError() }
        return url
        
    }
    
    static func getWeatherByCoordinates(latitude: Double, longitude: Double) -> URL {
        let weatherRequestURL = "\(URL.baseURL)?APPID=\(URL.APIKey)&lat=\(latitude)&lon=\(longitude)"
        
        guard let url = URL(string: weatherRequestURL) else { fatalError() }
        return url
        
    }
    
    static func getImageURLFromString(imageCode: String) -> URL {
        let imageUrl = "http://openweathermap.org/img/w/" + imageCode + ".png"
        guard let url = URL(string: imageUrl) else { fatalError() }
        return url
    }
    
    
    
    
    
}
