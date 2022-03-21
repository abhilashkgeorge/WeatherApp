//
//  DataStore.swift
//  WeatherApp
//
//  Created by Abhilash k George on 09/03/22.
//


import Foundation
import UIKit

class DataStore {
    var retreivedData: [PlaceDetails] = [PlaceDetails]()
    var favouritesArray: [PlaceDetails] = [PlaceDetails]()
    let fileManger = FileManager.default
    
    
    func savePlaces(placeDetails: [PlaceDetails]) {
        guard let placeDetailsURL = placeDetailsURL() else { return}
        if (!fileManger.fileExists(atPath: placeDetailsURL.path)) {
            
            fileManger.createFile(atPath: placeDetailsURL.path, contents: nil, attributes: nil  )
        }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: placeDetails, requiringSecureCoding: false)
            try data.write(to: placeDetailsURL)
           
        }catch  {
           fatalError()
        }
    }
    
    func placeDetailsURL() -> URL? {
        guard let url = fileManger.urls(for: .documentDirectory, in:  .userDomainMask).first else {
            return nil
        }
        
        let fileUrl = url.appendingPathComponent("PLacesList")
        return fileUrl
    }
    
    func loadPlaces() -> [PlaceDetails]{
        guard let placeDetailsURL = placeDetailsURL() else { return []}
        if (fileManger.fileExists(atPath: placeDetailsURL.path)) {
            do {
                let data = try Data(contentsOf: placeDetailsURL)
                if let allPlaceDetailes = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [PlaceDetails] {
                    retreivedData = allPlaceDetailes
                   // print(retreivedData)
                    
                }
            } catch {
                print("error in loading")
            }
            
        }
        return retreivedData
        
    }
    
    func loadFavourites() -> [PlaceDetails]{
        guard let placeDetailsURL = placeDetailsURL() else { return []}
        if (fileManger.fileExists(atPath: placeDetailsURL.path)) {
            do {
                let data = try Data(contentsOf: placeDetailsURL)
                if let allPlaceDetailes = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [PlaceDetails] {
                    let favourites = allPlaceDetailes.filter({$0.isFavourite == true})
                    favouritesArray = favourites
                   // print(favouritesArray.count)
                    
                }
            } catch {
                print("error in loading")
            }
            
        }
        return favouritesArray
        
    }
    
}


