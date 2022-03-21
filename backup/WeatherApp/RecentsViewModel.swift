//
//  RecentsViewModel.swift
//  WeatherApp
//
//  Created by Abhilash k George on 06/03/22.
//

import Foundation
import UIKit

class RecentsViewModel {
    
    var recentsList: [RecentSearches] = []
    
    init() {
        self.createRecentsArray()
    }
    
    
    
    func createRecentsArray() {
    
        recentsList.append(RecentSearches(location: "Bangalore", currentTemperature: "77", weatherIcon: UIImage(named: UIImage.AssetImages.Sunny.rawValue)!, weatherStatus: "Mostly Sunny", isFavourite: true))
        recentsList.append(RecentSearches(location: "Mangalore", currentTemperature: "80", weatherIcon:UIImage(named: UIImage.AssetImages.Sunny.rawValue)!, weatherStatus: "Mostly Windy", isFavourite: false))
    }
    
    
    func queryRecentSearch(place: String) {
        
    }
       
    
    func updateRecentSearch(city: String, isFavourite: Bool) {
    }
    
    func insertRecentSearch(recentSearchModel: CurrentWeatherViewModel) {
    }
    
    
    func deleteRecentSearch(recentSearchModel: CurrentWeatherViewModel) {
    }

    func deleteAllRecentSearches() {
        //recentsSearchesList = []
    }
    
}
