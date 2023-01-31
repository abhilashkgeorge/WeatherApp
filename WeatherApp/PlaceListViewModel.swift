//
//  PlaceListViewModel.swift
//  WeatherApp
//
//  Created by Abhilash k George on 10/03/22.
//

import Foundation
import UIKit


class PlaceListViewModel {
  
    var dataStore = DataStore()
    var placeDetails: [PlaceDetails] = [PlaceDetails]() {
        
        didSet {
            dataStore.savePlaces(placeDetails: placeDetails)
        }
    }
    init(placeDetails: [PlaceDetails]) {
        self.placeDetails = dataStore.loadPlaces()
    }
    
    // funcs to be implemented
    
    func count() -> Int {
        return placeDetails.count
    }
    
    func getPlaceDetailsAtIndex(index: Int) ->
    PlaceDetails {
        
        let places = placeDetails[index]
        
        let placeDetails = PlaceDetails(location: places.location, currentTemperature: places.currentTemperature, weatherIcon: places.weatherIcon, weatherStatus: places.weatherStatus, isFavourite: places.isFavourite)
        return placeDetails
    }
    
    func removePlaceAtIndex(index: Int) {
        placeDetails.remove(at: index)
    }
    
    func addPlace(place: PlaceDetails) {
        var index = -1
        if placeDetails.first == nil {
            
            self.placeDetails.append(PlaceDetails(location: place.location, currentTemperature: place.currentTemperature, weatherIcon: place.weatherIcon, weatherStatus: place.weatherStatus, isFavourite: place.isFavourite))
        } else {
            for placeName in placeDetails {
                index = index + 1
                if placeName.location == place.location {
                    placeDetails.remove(at: index)
                }
            }
            placeDetails.insert((PlaceDetails(location: place.location, currentTemperature: place.currentTemperature, weatherIcon: place.weatherIcon, weatherStatus: place.weatherStatus, isFavourite: place.isFavourite)), at: 0)
            dataStore.savePlaces(placeDetails: placeDetails)

       }
    }
    
    func toggleFavourites(placeName: String) {
        
        for list in placeDetails {
            if list.location == placeName {
                list.isFavourite = !list.isFavourite
               // print(list.isFavourite)
            }
        }
    }
    
    func getRecentSearchViewModel() -> [PlaceDetails] {
        let viewModel = self.placeDetails
        return viewModel
    }
    
    func getFavouritesViewModel() -> [PlaceDetails] {
        let favourites = self.placeDetails.filter({$0.isFavourite == true})
        // let viewModel = PlaceListViewModel(placeDetails: favourites)
        return favourites
    }
    
    func deleteFavouritePlace(place: String) {
        for favourites in self.placeDetails {
            if favourites.location == place {
                favourites.isFavourite = false
                dataStore.savePlaces(placeDetails: placeDetails)
            }
        }
    }

    func deleteAllFavourites() {
        for favourites in self.placeDetails {
            favourites.isFavourite = false
            dataStore.savePlaces(placeDetails: self.placeDetails)
        }
        
    }
    
        func deleteRecentSearch(place: String) {
            for recents in self.placeDetails {
                if recents.location == place {
                    self.placeDetails = self.placeDetails.filter( {$0.location != place})
                    dataStore.savePlaces(placeDetails: placeDetails)
                }
            }
        }
    
        func deleteAllRecentSearches() {
    
            placeDetails.removeAll()
            dataStore.savePlaces(placeDetails: placeDetails)
            //let array = placeDetails.
        }
        
    
}
