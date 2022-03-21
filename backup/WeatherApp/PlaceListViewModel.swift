//
//  PlaceListViewModel.swift
//  WeatherApp
//
//  Created by Abhilash k George on 10/03/22.
//

import Foundation

protocol PlaceDetailsProtocol: AnyObject {
    func removePlaceAt(index: Int)
}

class placeDetailsViewModel {
    
    weak var delagate: PlaceDetailsProtocol?
    
    var placeDetails: [PlaceDetails] = [PlaceDetails]()
    
    init(placeDetails: [PlaceDetails]) {
        self.placeDetails = placeDetails
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
        delagate?.removePlaceAt(index: index)
    }
    
}
