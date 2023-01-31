//
//  ProfileCell.swift
//  AssignmentTableView
//
//  Created by Abhilash k George on 07/01/22.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView?
    @IBOutlet weak var nameText: UILabel?
    @IBOutlet weak var phonenumberText: UILabel?
    @IBOutlet weak var mailIdLbl: UILabel?
    @IBOutlet weak var genderLbl: UILabel?
    @IBOutlet weak var dobLbl: UILabel?
    
    func setProfiles(profile: Profiles) {
        profileImage?.image = profile.image
        nameText?.text = profile.fName + " " + profile.lName
        phonenumberText?.text = profile.phone
        genderLbl?.text = profile.gender
        mailIdLbl?.text = profile.mailId
        dobLbl?.text = profile.dob
        
    }
}
