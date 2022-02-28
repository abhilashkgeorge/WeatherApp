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
    //var location = Location()
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
    
    @IBAction func segmentedControlToggled(_ sender: Any) {
        
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
        currentDayDateTimeLabel.text = "\(currentViewModel.dt)"
        LocationLabel.text = currentViewModel.name + ", State Name"
        //favouriteHeartIconButton = currentViewModel.country
        currentTemperatureLabel.text = "\(currentViewModel.currentTemp)"
        weatherStatusIcon.image = UIImage(named: "icon_mostly_sunny_small")
        weatherStatusLabel.text =  currentViewModel.description
        //  segmentedControlButton = currentViewModel.country
        minMaxTempLabel.text = "\(currentViewModel.minTemp)-\(currentViewModel.maxTemp)"
        percipitationValue.text = "0%"
        humidityLabel.text = "\(currentViewModel.humudity)"
        windSpeedLabel.text = "\(currentViewModel.wind)"
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        getWeather()
    }
    
    private func getWeather() {
        apiManager.getWeather() { (weather, error) in
            if let error = error {
                print("Get weather error: \(error.localizedDescription)")
                return
            }
            guard let weather = weather  else { return }
            self.searchResult = weather
            print("Current Weather Object:")
            print(weather)
        }
    }
    
    
    func configureItems() {
        sideMenuConstraint.constant = -320
        view.backgroundColor = UIColor(named: "bg_color")
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "icon_search_white"), style: .done, target: self, action: nil)
        ]
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "icon_menu_white"), style: .done, target: self, action: #selector(hamburgerButtonPressed)),
            UIBarButtonItem(image: UIImage(named: "logo_splash"), style: .done, target: self, action: nil)
        ]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != sideMenuView {
            sideMenuConstraint.constant = -320
            navigationItem.leftBarButtonItems = [
                UIBarButtonItem(image: UIImage(named: "icon_menu_white"), style: .done, target: self, action: #selector(hamburgerButtonPressed)),
                UIBarButtonItem(image: UIImage(named: "logo_splash"), style: .done, target: self, action: nil)
            ]
        }
    }
    
    @objc func hamburgerButtonPressed(_ sender: Any) {  sideMenuConstraint.constant = 0
        navigationItem.leftBarButtonItems = []
    }
    
}

