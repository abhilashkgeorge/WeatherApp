//
//  Service.swift
//  WeatherApp
//
//  Created by Abhilash k George on 23/02/22.
//

import Foundation
import UIKit

class Service :NSObject {
    
    
    static let shared = Service()
    
    private let cache = NSCache<NSString, UIImage>()
    
    public func getImageFromString(imageCode: String, completion: @escaping (_ image: UIImage) -> Void ) {
        
        if let image = cache.object(forKey: imageCode as NSString) {
            print("using cache")
            completion(image)
            return
        }
        
        let imageUrl = "https://openweathermap.org/img/w/\(imageCode).png"
        guard let url = URL(string: imageUrl) else { return }

        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            guard  error == nil else {
                fatalError("error in api call")
            }


            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200  else {
               fatalError("response error")
            }
            
            guard let data = data else {
                fatalError("data error")
            }
           
            if let image = UIImage(data: data) {
                print("using Api")
                self?.cache.setObject(image, forKey: imageCode as NSString)
                
                completion(image)
            }
            
        }).resume()
    }
}
