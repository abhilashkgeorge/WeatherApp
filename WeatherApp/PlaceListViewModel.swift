//
//  PlaceListViewModel.swift
//  WeatherApp
//
//  Created by Abhilash k George on 10/03/22.
//

import Foundation

//protocol PlaceDetailsProtocol: AnyObject {
//    func removePlaceAt(index: Int)
//}

class PlaceListViewModel {
    //   weak var delagate: PlaceDetailsProtocol?
    var dataStore = DataStore()
    var placeDetails: [PlaceDetails] = [PlaceDetails]() //10values
    
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
        
        //  delagate?.removePlaceAt(index: index)
    }
    
    func addPlace(place: PlaceDetails) {
        var index = -1
        if placeDetails.first == nil {
            
            placeDetails.append(PlaceDetails(location: place.location, currentTemperature: place.currentTemperature, weatherIcon: place.weatherIcon, weatherStatus: place.weatherStatus, isFavourite: place.isFavourite))
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
    
    func getRecentSearchViewModel() -> PlaceListViewModel {
        let viewModel = PlaceListViewModel(placeDetails: self.placeDetails)
        return viewModel
    }
    
    func getFavouritesViewModel() -> PlaceListViewModel {
        let favourites = placeDetails.filter({$0.isFavourite == true})
        let viewModel = PlaceListViewModel(placeDetails: favourites)
        return viewModel
    }
}
