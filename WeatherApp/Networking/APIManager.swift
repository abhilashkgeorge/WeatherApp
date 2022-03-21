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





