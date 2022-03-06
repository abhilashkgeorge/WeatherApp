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
    var isRecentsSegue: Bool = false
    var favouritesList = FavouritesViewModel()
    var recentSearchesList = RecentsViewModel()
    var numberOfCities = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        numberOfCities = favouritesList.favouritesList.count
        configureView()
  
    }
    
    func configureView() {
        if isRecentsSegue {
            deleteAllButton.setTitle("Clear All", for: .normal)
        } else {
            deleteAllButton.setTitle("Remove All", for: .normal)
            infoLabel.text = "\(numberOfCities) Cities added as favourite"
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
            alert.dismiss(animated: true, completion: nil)
        }
        present(alert, animated: true, completion: nil)
        alert.addAction(optionNo)
        alert.addAction(optionYes)
        
    }
    
}

extension RecentsFavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isRecentsSegue {
            return favouritesList.favouritesList.count
        }else {
            return recentSearchesList.recentsList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCell
        
        if !isRecentsSegue {
            cell.placeNameLabel.text = favouritesList.favouritesList[indexPath.row].location
            cell.weatherStatusLabel.text = favouritesList.favouritesList[indexPath.row].weatherStatus
            cell.currentTempLabel.text = "\(favouritesList.favouritesList[indexPath.row].currentTemperature)"
            cell.favouriteHeartIcon.image = UIImage(named: UIImage.AssetImages.FavActive.rawValue)
            return cell
        } else {
            cell.placeNameLabel.text = recentSearchesList.recentsList[indexPath.row].location
            cell.favouriteHeartIcon.image = UIImage(named: UIImage.AssetImages.FavActive.rawValue)
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if !isRecentsSegue {
                favouritesList.favouritesList.remove(at: indexPath.row)
            } else {
                recentSearchesList.recentsList.remove(at: indexPath.row)
            }
            numberOfCities = favouritesList.favouritesList.count
            listTableView.deleteRows(at: [indexPath],
                                     with: .left)
            listTableView.reloadData()
            
        }
    }
    
}
