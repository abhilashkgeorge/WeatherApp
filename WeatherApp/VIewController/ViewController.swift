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
    let location = Location()
    let globalFunctions = GlobalFunctions()
    var isFavoritesActive: Bool = false
    var isSearchByLocation = false
    let searchView = UITableView()
    let searchBar = UISearchBar()
    
    var favourites: [String]?
    //MARK: Connection elements from storyboard
    private(set) var currentViewModel: CurrentWeatherViewModel?
    @IBOutlet weak var currentDayDateTimeLabel: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var favouriteHeartIconButton: UIButton!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var weatherStatusIcon: UIImageView!
    @IBOutlet weak var segmentedControlButton: UISegmentedControl!
    @IBOutlet weak var minMaxTempLabel: UILabel!
    @IBOutlet weak var percipitationValue: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideMenuView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        getWeather()
    }
    
    
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           if segue.identifier == String.Identifiers.favouriteViewControllerIdentifier.rawValue {
               let vc = segue.destination as? RecentsFavouritesViewController
               vc?.navigationItem.title = "Favourite"
               vc?.navigationController?.navigationBar.backgroundColor = .white
               sideMenuConstraint.constant = -340
               configureNavigationBar()
               
           }
           
           if segue.identifier == String.Identifiers.recentsViewControllerIdentifier.rawValue {
               let vc = segue.destination as? RecentsFavouritesViewController
               vc?.navigationItem.title = "Recent Search"
               vc?.navigationController?.navigationBar.backgroundColor = .white
               vc?.isRecentsSegue = true
               sideMenuConstraint.constant = -340
               configureNavigationBar()
               
           }
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
        currentDayDateTimeLabel.addCharacterSpacing()
        LocationLabel.text = currentViewModel.name + "," + currentViewModel.weatherModel.sys.country
        weatherStatusIcon.image = UIImage(named: UIImage.AssetImages.Sunny.rawValue)
        weatherStatusLabel.text =  currentViewModel.description
        percipitationValue.text = "0%"
        humidityLabel.text = "\(currentViewModel.humudity)"
        windSpeedLabel.text = "\(currentViewModel.wind)"
        isFavoritesActive = true
    }
    
    private func getWeather() {
        if isSearchByLocation == false {
            location.configureCurrentLocation { location in
                self.apiManager.getWeatherByCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                self.configureWeather()
            }
        }else {
            if let searchText = searchBar.text {
                location.configureCurrentLocation { location in
                    self.apiManager.getWeatherByCity(city: searchText)
                    self.configureWeather()
                }
            }
        }
    }
    
    func configureWeather() {
        self.apiManager.getWeather() { (weather, error) in
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
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: UIImage.AssetImages.SearchIcon.rawValue), style: .done, target: self, action: #selector(searchItemTapped))
        ]
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: UIImage.AssetImages.HamburgerMenu.rawValue), style: .done, target: self, action: #selector(hamburgerButtonPressed)),
            UIBarButtonItem(image: UIImage(named: UIImage.AssetImages.Logo.rawValue), style: .done, target: self, action: nil)
        ]
    }
    
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        configureItems()
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func checkIfFavourite() {
        
        
    }
    
    @IBAction func favouriteButtonTapped(_ sender: Any) {
        
        //guard let currentViewModel = currentViewModel else { return }
        
        if favourites == nil {
            if isFavoritesActive{
                addToFavourites()
            } else {
                favouriteHeartIconButton.setImage(UIImage(named: UIImage.AssetImages.FavInactive.rawValue), for: .normal)
            }
            isFavoritesActive = !isFavoritesActive
        } else {
            
        }
    }
    
 
    
    func addToFavourites() {
        
        favouriteHeartIconButton.setImage(UIImage(named: UIImage.AssetImages.FavActive.rawValue), for: .normal)
        guard let currentViewModel = currentViewModel else {
            return
        }
        
        
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
            minMaxTempLabel.text = minTemp + "°" + "-"  + maxTemp + "°"
        }else {
            let currentTemp = globalFunctions.convertKelvinToFahrenheit(value: currentViewModel.currentTemp)
            let minTemp = globalFunctions.convertKelvinToFahrenheit(value: currentViewModel.minTemp)
            let maxTemp = globalFunctions.convertKelvinToFahrenheit(value: currentViewModel.maxTemp)
            currentTemperatureLabel.text = currentTemp
            minMaxTempLabel.text = minTemp + "°" + "-"  + maxTemp + "°"
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

extension ViewController: UISearchBarDelegate {
    
    @objc func searchItemTapped() {
        searchView.backgroundColor = .white
        searchView.frame = super.view.bounds
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.white
            textfield.placeholder = "Search for City"
        }
        
        view.addSubview(searchView)
        view.addSubview(searchBar)
        
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: searchView.topAnchor,constant: 50),
            searchBar.leftAnchor.constraint(equalTo: searchView.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: searchView.rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSearch()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        isSearchByLocation = true
        getWeather()
        hideSearch()
    }
    
    func hideSearch() {
        searchView.removeFromSuperview()
        searchBar.removeFromSuperview()
        configureNavigationBar()
    }
    
}
