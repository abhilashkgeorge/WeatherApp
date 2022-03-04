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
    var favouritesList = [CustomClass]()
    var recentsSearchesList = [CustomClass]()
    
    var temp = ["this", "that", "here" , "there"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
    }
}

extension RecentsFavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temp.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
