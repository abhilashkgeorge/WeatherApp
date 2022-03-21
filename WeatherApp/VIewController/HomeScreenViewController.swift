//
//  ViewController.swift
//  WeatherApp
//
//  Created by Abhilash k George on 22/02/22.
//

import UIKit
import SwiftUI


class HomeScreenViewController: UIViewController {
    private let apiManager = APIManager()
    let location = Location()
    let service = Service()
    let additionalFunctions = AdditionalFunctions()
    var isFavoritesActive: Bool = false
    var isSearchByLocation = false
    let searchView = UITableView()
    let searchBar = UISearchBar()
    let dataStore = DataStore()
    var recentsViewController = RecentsFavouritesViewController()
    var placeDetails: [PlaceDetails] = [PlaceDetails]()
    
    
    var recentSearches: [String] = []
    //MARK: Connection elements from storyboard
    private(set) var currentViewModel: CurrentWeatherViewModel?
    var placeListViewModel: PlaceListViewModel = PlaceListViewModel(placeDetails:[PlaceDetails]())
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
    @IBOutlet weak var addToFavouriteLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        getWeather()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as? RecentsFavouritesViewController
        sideMenuConstraint.constant = -340
        configureNavigationBar()
        navigationController?.navigationBar.tintColor = .black
        
        if segue.identifier == String.Identifiers.favouriteViewControllerIdentifier.rawValue {
            vc?.barButtonTitleItem.title = "Favourites"
            navigationController?.navigationBar.backgroundColor = .white
        }
        
        if segue.identifier == String.Identifiers.recentsViewControllerIdentifier.rawValue {
            vc?.barButtonTitleItem.title = " Recent Search"
            navigationController?.navigationBar.backgroundColor = .white
            vc?.isRecentsSegue = true
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
        //        guard var placeList = placesList else { return }
        
        
        
        segmentedControlToggled(Any.self)
        currentDayDateTimeLabel.text = "\(currentViewModel.dt)"
        currentTemperatureLabel.text = additionalFunctions.convertKelvinToCelsius(value: currentViewModel.currentTemp)
        currentDayDateTimeLabel.addCharacterSpacing()
        LocationLabel.text = currentViewModel.name + "," + currentViewModel.weatherModel.sys.country
        weatherStatusLabel.text =  currentViewModel.description
        percipitationValue.text = "0%"
        humidityLabel.text = "\(currentViewModel.humudity)"
        windSpeedLabel.text = "\(currentViewModel.wind)"
        isFavoritesActive = checkIfFavourite(location: LocationLabel.text!)
        let currentTemp = "\(currentTemperatureLabel.text ?? "")°c"
        
        
        service.getImageFromString(imageCode: currentViewModel.weatherIcon) { (img) in
            DispatchQueue.main.async {
                self.weatherStatusIcon.image = img
                let place = PlaceDetails(location: self.LocationLabel.text ?? "", currentTemperature: currentTemp , weatherIcon: self.weatherStatusIcon.image!, weatherStatus:self.weatherStatusLabel.text  ?? "", isFavourite: self.isFavoritesActive)
                if self.isSearchByLocation == true {
                    self.placeListViewModel.addPlace(place: place)
                    self.dataStore.savePlaces(placeDetails: self.placeListViewModel.placeDetails)
                }
                
            }
            
        }
        
        
    }
    
    
    private func getWeather() {
        if isSearchByLocation == false {
            location.configureCurrentLocation { location in
                let url =                 URL.getWeatherByCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                self.configureWeather(url: url)
            }
        }else {
            if let searchText = searchBar.text {
                location.configureCurrentLocation { location in
                    let url = URL.getWeatherByCity(city: searchText)
                    self.configureWeather(url: url)
                    self.recentSearches = [searchText]
                   // print(self.recentSearches)
                }
            }
        }
    }
    
    func configureWeather(url: String) {
        self.apiManager.getWeather(url: url) { (weather, error) in
            if let error = error {
                print("Get weather error: \(error)")
                return
            }
            guard let weather = weather  else {return }
            self.searchResult = weather
        }
        //        if self.searchResult == nil {
        //            self.showAlert(title: "Bahd", message: "TryAgain")
        //
        //        }
        
        
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
            UIBarButtonItem(image: UIImage(named: UIImage.AssetImages.SmallLogo.rawValue), style: .done, target: self, action: nil)
        ]
    }
    
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        configureItems()
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func checkIfFavourite(location: String) -> Bool {
        
        let placeList = dataStore.loadPlaces()
        
        
        for place in placeList {
            if place.location == location {
                if place.isFavourite == true {
                    favouriteHeartIconButton.setImage(UIImage(named: UIImage.AssetImages.FavActive.rawValue), for: .normal)
                    return true
                }
            }
        }
        favouriteHeartIconButton.setImage(UIImage(named: UIImage.AssetImages.FavInactive.rawValue), for: .normal)
        return false
        
    }
    
    @IBAction func favouriteButtonTapped(_ sender: Any) {
        toggleIconFavourites()
        let placesList = dataStore.loadPlaces()
        guard let currentViewModel = currentViewModel else {
            return
        }
        let currentTemp = "\(currentTemperatureLabel.text ?? "")°c"
        if isSearchByLocation == false {
            let place = PlaceDetails(location: LocationLabel.text ?? "", currentTemperature: currentTemp , weatherIcon: weatherStatusIcon.image!, weatherStatus: weatherStatusLabel.text  ?? "", isFavourite: true)
            placeListViewModel.addPlace(place: place)
            dataStore.savePlaces(placeDetails: placeListViewModel.placeDetails)

        }
        for list in placesList {
            if list.location == currentViewModel.name + "," + currentViewModel.weatherModel.sys.country {
                if list.isFavourite == true {
                    list.isFavourite = false
                } else {
                    list.isFavourite = true
                }
                
            }
            
            dataStore.savePlaces(placeDetails: placesList)
        }
    }
    
    func toggleIconFavourites() {
        if isFavoritesActive == false{
            placeListViewModel.toggleFavourites(placeName: LocationLabel.text!)
            favouriteHeartIconButton.setImage(UIImage(named: UIImage.AssetImages.FavActive.rawValue), for: .normal)
            addToFavouriteLabel.text = "Added to favourites"
            isFavoritesActive = true
        } else {
            placeListViewModel.toggleFavourites(placeName: LocationLabel.text!)
            favouriteHeartIconButton.setImage(UIImage(named: UIImage.AssetImages.FavInactive.rawValue), for: .normal)
            addToFavouriteLabel.text = "Add to favourites"
            isFavoritesActive = false
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
            let currentTemp = additionalFunctions.convertKelvinToCelsius(value: currentViewModel.currentTemp)
            let minTemp = additionalFunctions.convertKelvinToCelsius(value: currentViewModel.minTemp)
            let maxTemp = additionalFunctions.convertKelvinToCelsius(value: currentViewModel.maxTemp)
            
            currentTemperatureLabel.text = currentTemp
            minMaxTempLabel.text = minTemp + "°" + "-"  + maxTemp + "°"
        }else {
            let currentTemp = additionalFunctions.convertKelvinToFahrenheit(value: currentViewModel.currentTemp)
            let minTemp = additionalFunctions.convertKelvinToFahrenheit(value: currentViewModel.minTemp)
            let maxTemp = additionalFunctions.convertKelvinToFahrenheit(value: currentViewModel.maxTemp)
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

extension HomeScreenViewController: UISearchBarDelegate {
    
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
        navigationController?.navigationBar.isHidden = true
        
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
        searchBar.text = ""
    }
    
    func hideSearch() {
        navigationController?.navigationBar.isHidden = false
        searchView.removeFromSuperview()
        searchBar.removeFromSuperview()
        configureNavigationBar()
    }
    
}
