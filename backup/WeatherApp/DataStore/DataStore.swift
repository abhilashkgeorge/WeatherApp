//
//  DataStore.swift
//  WeatherApp
//
//  Created by Abhilash k George on 09/03/22.
//

import Foundation

class DataStore {
    
    let FacouritesUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Favourites List")
    let recentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Recent List")
    
}

