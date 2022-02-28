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
    let weatherModel: WeatherModel
    private(set) var dt: String = ""
    private(set) var name: String = ""
    private(set) var country: String = ""
    private(set) var isFavouriteSelected: Bool? = false
    private(set) var weatherIcon: String = ""
    private(set) var description: String = ""
    private(set) var currentTemp: Double = 0.0
    private(set) var isDegreeConversionSelected: Bool? = false
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
    dateFormatter.dateFormat = "EEE, dd MMM yyyy hh:mm a"
    return dateFormatter
}()

extension CurrentWeatherViewModel {
    
    private func updateDt(weatherModel: WeatherModel) -> String {
        dateFormatter.timeZone = TimeZone(identifier: "\(weatherModel.timezone)")
        let readableDate = Date(timeIntervalSince1970: TimeInterval(weatherModel.dt))
        return dateFormatter.string(from: readableDate)
        
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

extension CurrentWeatherViewModel {
    
    func convertDoubleToString(value: Double) -> String {
        return String(format: "%.0f", value)
    }
    
    
}
//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Abhilash k George on 24/02/22.
//

//    import Foundation
//    import UIKit
//
//    public class CurrentWeatherViewModel {
//        var timeZone: Int
//        var name: String
//        var country: String
//        var isFavouriteSelected: Bool?
//        var weatherIcon: String
//        var currentTemp: Double
//        var isDegreeConversionSelected: Bool?
//        var status: String
//        var minTemp: Double
//        var maxTemp: Double
//        var percepitation: Double
//        var humudity: Int
//        var wind: Double
//
//         var weatherService: Service
//
//        init(model: WeatherModel, weatherService: Service) {
//            self.timeZone = model.timezone
//            self.name = model.name
//            self.country = model.sys.country
//            self.weatherIcon = model.weather.last?.icon ?? ""
//            self.currentTemp = model.main.temp
//            self.status = model.weather.last?.main ?? ""
//            self.minTemp = model.main.temp_min
//            self.maxTemp = model.main.temp_max
//            self.percepitation = model.main.feels_like
//            self.humudity = model.main.humidity
//            self.wind = model.wind.speed
//            self.weatherService = weatherService
//        }
//
//        func refresh() {
//            weatherService.getWeatherData({ weather in
//                DispatchQueue.main.async {
//                    self.timeZone = weather.timezone
//                    self.name = weather.name
//                    self.country = weather.sys.country
//                    self.weatherIcon = weather.weather.last?.icon ?? ""
//                    self.currentTemp = weather.main.temp
//                    self.status = weather.weather.last?.main ?? ""
//                    self.minTemp = weather.main.temp_min
//                    self.maxTemp = weather.main.temp_max
//                    self.percepitation = weather.main.feels_like
//                    self.humudity = weather.main.humidity
//                    self.wind = weather.wind.speed
//                }
//            })
//        }
//    }

//}
