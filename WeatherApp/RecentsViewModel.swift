//
//  RecentsViewModel.swift
//  WeatherApp
//
//  Created by Abhilash k George on 06/03/22.
//

import Foundation
import UIKit

class RecentsViewModel {
    let dataStore = DataStore()
    var recentsList: [PlaceDetails] = [] {
        didSet {
            dataStore.savePlaces(placeDetails: recentsList)
        }
    }
 
    
    init() {
        self.recentsList = dataStore.loadPlaces()
    }
    
   
    
    func deleteRecentSearch(place: String) {
        for recents in recentsList {
            if recents.location == place {
                recents.isFavourite = false
                dataStore.savePlaces(placeDetails: recentsList)
            }
        }
    }

    func deleteAllRecentSearches() {
        recentsList = []
    //    dataStore.savePlaces(placeDetails: recentsList)
    }
    
}
