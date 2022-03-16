//
//  APIManager.swift
//  WeatherApp
//
//  Created by Abhilash k George on 27/02/22.
//

import Foundation
import UIKit

class APIManager {
    static let shared = APIManager()
    
//    func getWeather(url: URL, completionHandler: @escaping(_ weather: Any) -> ()) {
//
//        let session = URLSession.shared
//
//        session.dataTask(with: url) { (data, response, error) in
//
//            guard error != nil else {
//
//                return
//            }
//
//            if let response = response {
//                print(response)
//            } else {
//                fatalError()
//            }
//
//            if let data = data {
//                do {
//                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//                    completionHandler(jsonResponse)
//                } catch {
//                    fatalError()
//                }
//            }
//
//        }.resume()
//    }
    
    func getImage(from url: URL, completion: @escaping (_ image: UIImage) -> Void ) {
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            guard error != nil else {

                
                return
            }
            
            if let response = response {
                print(response)
            } else {
                fatalError()
            }
                
                guard let data = data else {
                    fatalError()
                }
               
                if let image = UIImage(data: data) {
                    completion(image)
                }
                
            }.resume()
        }
    








//class APIManager {
//
//    let baseURL = "https://api.openweathermap.org/data/2.5/weather"
//    let APIKey = "5ea7139e9797a5d9d28a0b895063e7a5"
//    var urlString: String = ""
//
//    func getWeatherByCity(city: String) {
//        let weatherRequestURL = "\(baseURL)?q=\(city)&APPID=\(APIKey)"
//        urlString = weatherRequestURL
//        print(urlString)
//    }
//
//    func getWeatherByCoordinates(latitude: Double, longitude: Double) {
//        let weatherRequestURL = "\(baseURL)?APPID=\(APIKey)&lat=\(latitude)&lon=\(longitude)"
//        urlString = weatherRequestURL
//    }

    func getWeather(url: String,completion: @escaping (_ weather: WeatherModel?, _ error: Error?) -> Void) {
        getJSONFromURL(urlString: url ) { (data, error) in
            guard let data = data, error == nil else {
                print("Failed to get data")
                return completion(nil, error)
            }
            self.createWeatherObjectWith(json: data, completion: { (weather, error) in
                if let error = error {
                    print("Failed to convert data")
                    return completion(nil, error)
                }
                return completion(weather, nil)
            })
        }
    }
}

extension APIManager {
    private func getJSONFromURL(urlString: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Error: Cannot create URL from string")
            return
        }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            guard error == nil else {
                print("Error calling api")
                return completion(nil, error)
            }
            guard let responseData = data else {
                print("Data is nil")
                return completion(nil, error)
            }
            completion(responseData, nil)
        }
        task.resume()
    }

    private func createWeatherObjectWith(json: Data, completion: @escaping (_ data: WeatherModel?, _ error: Error?) -> Void) {
        do {
            let decoder = JSONDecoder()
            let weather = try decoder.decode(WeatherModel.self, from: json)
            return completion(weather, nil)
        } catch let error {
            print("Error creating current weather from JSON because: \(error)")
            return completion(nil, error)
        }
    }
}





