//
//  FavouritesViewModel.swift
//  WeatherApp
//
//  Created by Abhilash k George on 06/03/22.
//


import Foundation
import UIKit

class FavouritesViewModel {
    
    var favouritesList: [PlaceDetails] = []
    let dataStore = DataStore()
    
    init() {
        self.favouritesList = dataStore.loadFavourites()
    }


    
    func deleteFavouritePlace(place: String) {
        for favourites in favouritesList {
            if favourites.location == place {
                favourites.isFavourite = false
                dataStore.savePlaces(placeDetails: favouritesList)
            }
        }
    }
    
    
    
    func deleteAllFavourites() {
        for favourites in favouritesList {
            favourites.isFavourite = false
            dataStore.savePlaces(placeDetails: favouritesList)
        }
        favouritesList = []
        
    }
    
}
