//
//  CustomCell.swift
//  WeatherApp
//
//  Created by Abhilash k George on 04/03/22.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var favouriteHeartIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        placeNameLabel.text = "abhilash"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
