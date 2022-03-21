//
//  String + Ext.swift
//  WeatherApp
//
//  Created by Abhilash k George on 20/03/22.
//

import Foundation

extension String {
    
    enum Identifiers: String {
        case favouriteViewControllerIdentifier = "favouriteScreenIdentifier"
        case recentsViewControllerIdentifier = "recentsScreenIdentifier"
    }
    
    enum dateFormatter: String {
        case DateFormat = "EEE, dd MMM yyyy hh:mm a"
    }
}
