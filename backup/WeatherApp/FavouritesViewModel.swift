//
//  FavouritesViewModel.swift
//  WeatherApp
//
//  Created by Abhilash k George on 06/03/22.
//


import Foundation
import UIKit

class FavouritesViewModel {
    
    var favouritesList: [Favourites] = []
    
    init() {
        self.createFavouritesArray()
    }

    func createFavouritesArray() {

        favouritesList.append(Favourites(location: "Bangalore", currentTemperature: "36", weatherIcon: UIImage(named: UIImage.AssetImages.Sunny.rawValue)!, weatherStatus: "Mostly Sunny"))
        favouritesList.append(Favourites(location: "Mangalore", currentTemperature: "34", weatherIcon: UIImage(named: UIImage.AssetImages.Sunny.rawValue)!, weatherStatus: "Smoke"))
        favouritesList.append(Favourites(location: "Chennai", currentTemperature: "35", weatherIcon: UIImage(named: UIImage.AssetImages.Sunny.rawValue)!, weatherStatus: "Cloudy"))
        favouritesList.append(Favourites(location: "Delhi", currentTemperature: "31", weatherIcon: UIImage(named: UIImage.AssetImages.Sunny.rawValue)!, weatherStatus: "Windy"))
        favouritesList.append(Favourites(location: "Kuwait", currentTemperature: "40", weatherIcon: UIImage(named: UIImage.AssetImages.Sunny.rawValue)!, weatherStatus: "Sunny"))

    }
    
    func queryFavourites(place:String) {
        
        
    }

//
//    func insertFavourite(place: PlaceDetails) {
//        favouritesList.append(PlaceDetails(location: place.location, currentTemperature: place.currentTemperature, weatherIcon: place.weatherIcon, weatherStatus: place.weatherStatus, isFavourite: place.isFavourite))
//    }
    
    func deleteFavouritePlace(favouriteModel: CurrentWeatherViewModel) {
    }
    
    
    func deleteAllFavourites() {
        //favouritesList = []
        
    }
    
    func deleteAllRecentSearches() {
        //recentsSearchesList = []
    }
    
}
