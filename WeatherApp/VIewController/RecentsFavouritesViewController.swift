//
//  RecentsFavouritesViewController.swift
//  WeatherApp
//
//  Created by Abhilash k George on 28/02/22.
//

import UIKit



class RecentsFavouritesViewController: UIViewController {
    
    @IBOutlet weak var deleteAllButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var searchIcon: UIBarButtonItem!
    @IBOutlet weak var barButtonTitleItem: UIBarButtonItem!
    let searchBar = UISearchBar()
    var placeListViewModel: PlaceListViewModel?
    var placeDetail: [PlaceDetails] = [PlaceDetails]()
    var isRecentsSegue: Bool = false
    let additionalFunctions = AdditionalFunctions()
    var recentsArray: [PlaceDetails] = []
    var favouritesArray: [PlaceDetails] = []
    var numberOfCities = 0
    var dataStore = DataStore()
    var searchPlace = [PlaceDetails]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        searchBar.delegate = self
        recentsArray = dataStore.loadPlaces()
        favouritesArray = dataStore.loadFavourites()
        configureView()
        
    }
    
    func configureView() {
        numberOfCities = favouritesArray.count
        if numberOfCities == 0 && !isRecentsSegue{
            setUpEmptyTableView()
        } else if !isRecentsSegue{
            deleteAllButton.setTitle("Remove All", for: .normal)
            infoLabel.text = "\(numberOfCities) Cities added as favourite"
        }
        if isRecentsSegue && recentsArray.count == 0 {
            setUpEmptyTableView()
        } else {
            deleteAllButton.setTitle("Clear All", for: .normal)
        }
    }
    
    @IBAction func deleteAllButtonTapped(_ sender: Any) {
        
        

        var message = ""
        
        if !isRecentsSegue {
            
            message = "Are you sure want to remove all the favourites?"
            
        } else {
            
            message = "Are you sure want to clear all the recent Searches?"
        }
        let alert = UIAlertController(title: "Clear All", message: message , preferredStyle: .alert)
        let optionNo = UIAlertAction(title: "No", style: .cancel) { (selection) in
            alert.dismiss(animated: true, completion: nil)
        }
        let optionYes = UIAlertAction(title: "Yes", style: .default) { (selection) in
            guard let placeListViewModel = self.placeListViewModel else {
                return
            }
            if self.isRecentsSegue {
                self.recentsArray = []
                placeListViewModel.deleteAllRecentSearches()
                self.listTableView.reloadData()
                
            } else {
                self.favouritesArray = []
                placeListViewModel.deleteAllFavourites()
                self.listTableView.reloadData()
            }
            self.setUpEmptyTableView()
            alert.dismiss(animated: true, completion: nil)
        }
        present(alert, animated: true, completion: nil)
        alert.addAction(optionNo)
        alert.addAction(optionYes)
        
    }
    
    //MARK: search
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = nil
        searchBar.showsCancelButton = false
        searchBar.becomeFirstResponder()
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .white
        navigationController?.popViewController(animated: true)
    }
    
    func setUpEmptyTableView() {
        
        let imageView = UIImageView()
        let image = UIImage(named: UIImage.AssetImages.Empty.rawValue)!
        imageView.image = image
        imageView.frame.size.width = 159
        imageView.frame.size.height = 84
        imageView.center = self.view.center
        view.addSubview(imageView)
        
        let label = UILabel()
        label.frame = CGRect(x: imageView.bounds.origin.x, y: imageView.bounds.origin.y, width: 300, height: 45)
        
        if !isRecentsSegue {
            label.text = "No Favourites Added"
        } else {
            label.text = "No Recent Search"
        }
        
        label.textColor = .white
        label.center = imageView.center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        infoLabel.isHidden = true
        deleteAllButton.isHidden = true
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
}



extension RecentsFavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isRecentsSegue {
            return favouritesArray.count
            
        }else {
            return recentsArray.count
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WeatherCell
        if !isRecentsSegue {
            cell.placeNameLabel.text = favouritesArray[indexPath.row].location
            cell.weatherStatusLabel.text = favouritesArray[indexPath.row].weatherStatus
            cell.currentTempLabel.text = "\(favouritesArray[indexPath.row].currentTemperature)"
            cell.currentWeatherIcon.image = favouritesArray[indexPath.row].weatherIcon
            cell.favouriteHeartIcon.image = additionalFunctions.setFavouritesImage(status: favouritesArray[indexPath.row].isFavourite)
            return cell
        } else {
            cell.placeNameLabel.text = recentsArray[indexPath.row].location
            cell.weatherStatusLabel.text = recentsArray[indexPath.row].weatherStatus
            cell.currentTempLabel.text = "\(recentsArray[indexPath.row].currentTemperature)"
            cell.currentWeatherIcon.image = recentsArray[indexPath.row].weatherIcon
            cell.favouriteHeartIcon.image = additionalFunctions.setFavouritesImage(status: recentsArray[indexPath.row].isFavourite)
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let placeListViewModel = placeListViewModel else { return
            
        }
        if editingStyle == .delete {
            
            if !isRecentsSegue {
                let placeName = favouritesArray[indexPath.row].location
                placeListViewModel.deleteFavouritePlace(place: placeName)
                favouritesArray.remove(at: indexPath.row)
                numberOfCities = favouritesArray.count
            } else {
                let placeName = recentsArray[indexPath.row].location
                placeListViewModel.deleteRecentSearch(place: placeName)
                recentsArray.remove(at: indexPath.row)

            }
            listTableView.deleteRows(at: [indexPath],
                                     with: .left)
            listTableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = recentsArray[indexPath.row]
        guard let homeViewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? HomeScreenViewController else { return }
        let name = place.location
        homeViewController.searchBar.text = name
        homeViewController.isSearchByLocation = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(homeViewController, animated: false)
    }
    
    
}

extension RecentsFavouritesViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if isRecentsSegue {
            
            recentsArray = recentsArray.filter { (item) -> Bool in
                
                if searchText == "" {
                    return true
                }else if item.location.lowercased().contains(searchText.lowercased()) {
                    return true
                }else {
                    return false
                }
            }
            listTableView.reloadData()
        } else {
            favouritesArray = favouritesArray.filter { (item) -> Bool in
                
                if searchText == "" {
                    return true
                }else if item.location.lowercased().contains(searchText.lowercased()) {
                    return true
                }else {
                    return false
                }
            }
            listTableView.reloadData()
        }
    }
}





