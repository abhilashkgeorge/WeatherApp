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
    var placeDetail: [PlaceDetails] = [PlaceDetails]()
    var placeListViewModel: PlaceListViewModel?
    var isRecentsSegue: Bool = false
    var favouritesList = FavouritesViewModel()
    var recentSearchesList = RecentsViewModel()
    let globalFunctions = GlobalFunctions()
    var recentsArray: [PlaceDetails] = []
    var favouritesArray: [PlaceDetails] = []
    var numberOfCities = 0
    var dataStore = DataStore()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        recentsArray = recentSearchesList.recentsList
        favouritesArray = favouritesList.favouritesList
        
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
            
            if self.isRecentsSegue {
                self.dataStore.retreivedData = []
                self.recentsArray = []
                self.recentSearchesList.deleteAllRecentSearches()
                self.listTableView.reloadData()
            } else {
                self.favouritesArray = []
                self.favouritesList.deleteAllFavourites()
                self.listTableView.reloadData()
            }
            alert.dismiss(animated: true, completion: nil)
        }
        present(alert, animated: true, completion: nil)
        alert.addAction(optionNo)
        alert.addAction(optionYes)
        
    }
   
    //MARK: search
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        let searchBar = UISearchBar()
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
//   guard let placeListViewModel = placeListViewModel else { return 2 }
//        if !isRecentsSegue {
//            let favourites = placeListViewModel.getFavouritesViewModel()
//            return favourites.count()
//
//        }else {
//            let recents = placeListViewModel.getRecentSearchViewModel()
//            print(recents.count())
//            return recents.count()
//
//           // return recentSearchesList.recentsList.count
//        }
                if !isRecentsSegue {
                   return favouritesArray.count
        
                }else {
                    return recentsArray.count
        
                   // return recentSearchesList.recentsList.count
                }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCell
     //   guard let placeListViewModel = placeListViewModel else { return UITableViewCell() }
//        if !isRecentsSegue {
//            cell.placeNameLabel.text = placeListViewModel.placeDetails[indexPath.row].location
//            cell.weatherStatusLabel.text = placeListViewModel.placeDetails[indexPath.row].weatherStatus
//            cell.currentTempLabel.text = "\(placeListViewModel.placeDetails[indexPath.row].currentTemperature)"
//            cell.favouriteHeartIcon.image = UIImage(named: UIImage.AssetImages.FavActive.rawValue)
//            return cell
//        } else {
//            cell.placeNameLabel.text = placeListViewModel.placeDetails[indexPath.row].location
//            cell.weatherStatusLabel.text = placeListViewModel.placeDetails[indexPath.row].weatherStatus
//            cell.currentTempLabel.text = "\(placeListViewModel.placeDetails[indexPath.row].currentTemperature)"
//            cell.favouriteHeartIcon.image = UIImage(named: UIImage.AssetImages.FavActive.rawValue)
//            return cell
        if !isRecentsSegue {
            cell.placeNameLabel.text = favouritesArray[indexPath.row].location
            cell.weatherStatusLabel.text = favouritesArray[indexPath.row].weatherStatus
            cell.currentTempLabel.text = "\(favouritesArray[indexPath.row].currentTemperature)"
            cell.currentWeatherIcon.image = favouritesArray[indexPath.row].weatherIcon
            cell.favouriteHeartIcon.image = globalFunctions.setFavouritesImage(status: favouritesArray[indexPath.row].isFavourite)
            return cell
        } else {
            cell.placeNameLabel.text = recentsArray[indexPath.row].location
            cell.weatherStatusLabel.text = recentsArray[indexPath.row].weatherStatus
            cell.currentTempLabel.text = "\(recentsArray[indexPath.row].currentTemperature)"
            cell.currentWeatherIcon.image = recentsArray[indexPath.row].weatherIcon
            cell.favouriteHeartIcon.image = globalFunctions.setFavouritesImage(status: recentsArray[indexPath.row].isFavourite)
            return cell
//            cell.placeNameLabel.text = recentSearchesList.recentsList[indexPath.row].location
//            cell.favouriteHeartIcon.image = UIImage(named: UIImage.AssetImages.FavActive.rawValue)
//            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if !isRecentsSegue {
                var favouritesArr = dataStore.loadFavourites()
                favouritesArr.remove(at: indexPath.row)
        
                favouritesArray[indexPath.row].isFavourite = false
                favouritesArray.remove(at: indexPath.row)
                favouritesList.deleteFavouritePlace(place: favouritesArray[indexPath.row].location)
                favouritesList.favouritesList.remove(at: indexPath.row)
                numberOfCities = favouritesArray.count
               
            } else {
                recentsArray.remove(at: indexPath.row)
                recentSearchesList.recentsList.remove(at: indexPath.row)
            }
            listTableView.deleteRows(at: [indexPath],
                                     with: .left)
            listTableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = recentsArray[indexPath.row]
        print(type(of: place))
        guard var homeViewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }

        homeViewController.placeListViewModel.getPlaceDetailsAtIndex(index: indexPath.row)
        
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .white
        
        navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    
}

