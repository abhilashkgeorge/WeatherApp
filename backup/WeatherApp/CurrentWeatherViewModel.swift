//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Abhilash k George on 24/02/22.
//

import Foundation
import UIKit

public struct CurrentWeatherViewModel {
    var globalFunctions = GlobalFunctions()
    let apiManager = APIManager()
    let weatherModel: WeatherModel
    var favouritesModel = FavouritesViewModel()
    var places: [PlaceDetails] = [PlaceDetails]()
    private(set) var dt: String = ""
    private(set) var name: String = ""
    private(set) var country: String = ""
    private(set) var isFavouriteSelected: Bool = true
    private(set) var weatherIcon: String = ""
    private(set) var description: String = ""
    private(set) var currentTemp: Double = 0.0
    private(set) var status: String = ""
    private(set) var minTemp: Double = 0.0
    private(set) var maxTemp: Double = 0.0
    private(set) var percepitation: Double = 0.0
    private(set) var humudity: Int = 0
    private(set) var wind: Double = 0.0
    
    init(weatherModel: WeatherModel) {
        self.weatherModel = weatherModel
        updateProperties()
    }
    
    mutating func updateProperties() {
        
        dt = updateDt(weatherModel: weatherModel)
        name =  updateName(weatherModel: weatherModel)
        country =  updatecountry(weatherModel: weatherModel)
        weatherIcon =  updateweatherIcon(weatherModel: weatherModel)
        currentTemp =  updateCurrentTemp(weatherModel: weatherModel)
        status =  updateStatus(weatherModel: weatherModel)
        minTemp =  updateMinTemp(weatherModel: weatherModel)
        description = updateDescription(weatherModel: weatherModel)
        maxTemp =  updateMaxTemp(weatherModel: weatherModel)
        percepitation =  updatePercipitation(weatherModel: weatherModel)
        humudity =  updateHumidity(weatherModel: weatherModel)
        wind =  updateWind(weatherModel: weatherModel)
    }
}

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = String.dateFormatter.DateFormat.rawValue
    return dateFormatter
}()

extension CurrentWeatherViewModel {
    
    private func updateDt(weatherModel: WeatherModel) -> String {
        dateFormatter.timeZone = TimeZone(identifier: "\(weatherModel.timezone)")
        let readableDate = Date(timeIntervalSince1970: TimeInterval(weatherModel.dt))
        return dateFormatter.string(from: readableDate).uppercased()
        
    }
    
    private func updateName(weatherModel: WeatherModel) -> String {
        return weatherModel.name
    }
    
    private func updatecountry(weatherModel: WeatherModel) -> String {
        return weatherModel.sys.country
    }
    
    private func updateweatherIcon(weatherModel: WeatherModel) -> String {
        
        guard let icon = weatherModel.weather.last?.icon else {
            return ""
        }
        return icon
    }
    
    private func updateCurrentTemp(weatherModel: WeatherModel) -> Double {
        return weatherModel.main.temp
    }
    
    private func updateStatus(weatherModel: WeatherModel) -> String {
        return weatherModel.weather.description
    }
    
    private func updateMinTemp(weatherModel: WeatherModel) -> Double {
        return weatherModel.main.temp_min
    }
    
    private func updateDescription(weatherModel: WeatherModel) -> String {
        guard let weatherDescription = weatherModel.weather.first?.description else { return "Not Found" }
        return weatherDescription
    }
    
    private func updateMaxTemp(weatherModel: WeatherModel) -> Double {
        return weatherModel.main.temp_max
    }
    
    private func updatePercipitation(weatherModel: WeatherModel) -> Double {
        return 0.0
    }
    
    private func updateHumidity(weatherModel: WeatherModel) -> Int  {
        return weatherModel.main.humidity
    }
    
    private func updateWind(weatherModel: WeatherModel) -> Double {
        return  weatherModel.wind.speed
    }
}

extension CurrentWeatherViewModel  {
    func convertDoubleToString(value: Double) -> String {
        return String(format: "%.0f", value)
    }
    
    
    
}

extension CurrentWeatherViewModel {
    
    mutating func addPlace(place: PlaceDetails) {
        
        places.append(PlaceDetails(location: place.location, currentTemperature: place.currentTemperature, weatherIcon: place.weatherIcon, weatherStatus: place.weatherStatus, isFavourite: place.isFavourite))
        
        for num in 0...places.count - 1 {
            print(places[num].location)
            
        }
        
        
//        for list in places {
//            if place.location == list.location {
//                return
//            } else {
//                places.append(PlaceDetails(location: place.location, currentTemperature: place.currentTemperature, weatherIcon: place.weatherIcon, weatherStatus: place.weatherStatus, isFavourite: place.isFavourite))
//            }
    //    }
    }
    
    mutating func toggleFavourites(placeName: String) {
        for list in places {
            if list.location == placeName {
                isFavouriteSelected = !isFavouriteSelected
            }
        }
    }
    
    func getRecentSearhViewModel() -> placeDetailsViewModel {
        
        let recentSearchPlacesList = placeDetailsViewModel(placeDetails: self.places)
        return recentSearchPlacesList
        
    }
    
    func getFavouritePlaces() -> placeDetailsViewModel {
        
        let filteredList  = places.filter({$0.isFavourite == true})
        let favouritePlacesList = placeDetailsViewModel(placeDetails: filteredList)
        return favouritePlacesList
        
    }
}
