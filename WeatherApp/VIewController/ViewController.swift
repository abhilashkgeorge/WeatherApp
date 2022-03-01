//
//  ViewController.swift
//  WeatherApp
//
//  Created by Abhilash k George on 22/02/22.
//

import UIKit
import SwiftUI


class ViewController: UIViewController {
    private let apiManager = APIManager()
    let globalFunctions = GlobalFunctions()
    var isFavoritesActive = true
    //Mark: Connection elements from storyboard
    private(set) var currentViewModel: CurrentWeatherViewModel?
    @IBOutlet weak var currentDayDateTimeLabel: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var favouriteHeartIconButton: UIButton!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var weatherStatusIcon: UIImageView!
    @IBOutlet weak var segmentedControlButton: UISegmentedControl!
    @IBOutlet weak var minMaxTempLabel: UILabel!
    //Mark: Percipitation Config
    @IBOutlet weak var percipitationValue: UILabel!
    //Mark: Humidity
    @IBOutlet weak var humidityLabel: UILabel!
    //pending for wind params
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideMenuView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        getWeather()
    }
    
    
    var searchResult: WeatherModel? {
        didSet {
            guard let searchResult = searchResult else {
                return
            }
            currentViewModel = CurrentWeatherViewModel.init(weatherModel: searchResult)
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    func updateView() {
        guard let currentViewModel = currentViewModel else {
            return
        }
        segmentedControlToggled(Any.self)
        currentDayDateTimeLabel.text = "\(currentViewModel.dt)"
        LocationLabel.text = currentViewModel.name + ", State Name"
        weatherStatusIcon.image = UIImage(named: "icon_mostly_sunny_small")
        weatherStatusLabel.text =  currentViewModel.description
        percipitationValue.text = "0%"
        humidityLabel.text = "\(currentViewModel.humudity)"
        windSpeedLabel.text = "\(currentViewModel.wind)"
        
        
    }
    
    private func getWeather() {
        apiManager.getWeather() { (weather, error) in
            if let error = error {
                print("Get weather error: \(error)")
                return
            }
            guard let weather = weather  else { return }
            self.searchResult = weather
        }
    }
    
    
    func configureItems() {
        segmentedControlToggled(Any.self)
        sideMenuConstraint.constant = -320
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "icon_search_white"), style: .done, target: self, action: #selector(searchItemTapped))
        ]
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "icon_menu_white"), style: .done, target: self, action: #selector(hamburgerButtonPressed)),
            UIBarButtonItem(image: UIImage(named: "logo_splash"), style: .done, target: self, action: nil)
        ]
    }
                            
                            @objc func searchItemTapped() {
                                
                            }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        configureItems()
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    
    @IBAction func favouriteButtonTapped(_ sender: Any) {
        if isFavoritesActive {
            favouriteHeartIconButton.setImage(UIImage(named: "icon_favourite_active"), for: .normal)
        } else {
            favouriteHeartIconButton.setImage(UIImage(named: "icon_favourite"), for: .normal)
        }
        isFavoritesActive = !isFavoritesActive
    }
    
    @IBAction func segmentedControlToggled(_ sender: Any) {
        guard let currentViewModel = currentViewModel else {
            return
        }
        
        segmentedControlButton.layer.borderWidth = 1.0
        segmentedControlButton.layer.cornerRadius = 5.0
        segmentedControlButton.layer.borderColor = UIColor.white.cgColor
        segmentedControlButton.layer.masksToBounds = true
        segmentedControlButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
        
        if segmentedControlButton.selectedSegmentIndex == 0 {
            let currentTemp = globalFunctions.convertKelvinToCelsius(value: currentViewModel.currentTemp)
            let minTemp = globalFunctions.convertKelvinToCelsius(value: currentViewModel.minTemp)
            let maxTemp = globalFunctions.convertKelvinToCelsius(value: currentViewModel.maxTemp)
            
            currentTemperatureLabel.text = currentTemp
            minMaxTempLabel.text = minTemp + "-"  + maxTemp
        }else {
            let currentTemp = globalFunctions.convertKelvinToFahrenheit(value: currentViewModel.currentTemp)
            let minTemp = globalFunctions.convertKelvinToFahrenheit(value: currentViewModel.minTemp)
            let maxTemp = globalFunctions.convertKelvinToFahrenheit(value: currentViewModel.maxTemp)
            currentTemperatureLabel.text = currentTemp
            minMaxTempLabel.text = minTemp + "-"  + maxTemp
        }
    }
    
    @objc func hamburgerButtonPressed(_ sender: Any) {
        
        sideMenuConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded() })
        navigationItem.leftBarButtonItems = []
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != sideMenuView {
            configureItems()
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
           
        }
    }
}

