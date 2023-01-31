//
//  Profiles.swift
//  AssignmentTableView
//
//  Created by Abhilash k George on 07/01/22.
//

import Foundation
import UIKit

class Profiles: NSObject, NSCoding {
    
    required convenience init?(coder: NSCoder) {
        guard let fName = coder.decodeObject(forKey: "fName") as? String,
        let lName = coder.decodeObject(forKey: "lName") as? String,
        let gender = coder.decodeObject(forKey: "gender") as? String,
        let address = coder.decodeObject(forKey: "address") as? String,
        let phone = coder.decodeObject(forKey: "phone") as? String,
        let dob = coder.decodeObject(forKey: "dob") as? String,
        let mailId = coder.decodeObject(forKey: "mailId") as? String,
        let image = coder.decodeObject(forKey: "image") as? UIImage
        
        else { return nil }

        self.init(
            image: image,
            fName: fName,
            lName: lName,
            phone: phone,
            gender: gender,
            dob: address,
            mailId: dob,
            address: mailId
        )
    }
    func encode(with coder: NSCoder) {
        coder.encode(image, forKey: "image")
        coder.encode(fName, forKey: "fName")
        coder.encode(lName, forKey: "lName")
        coder.encode(phone, forKey: "phone")
        coder.encode(gender, forKey: "gender")
        coder.encode(dob, forKey: "dob")
        coder.encode(mailId, forKey: "mailId")
        coder.encode(address, forKey: "address")
    }
     
    
    var image: UIImage
    var fName: String
    var lName: String
    var gender: String
    var phone: String
    var dob: String
    var mailId: String
    var address: String
    
    
    init(image: UIImage, fName: String, lName: String, phone: String, gender: String,  dob: String, mailId: String, address: String) {

        self.image = image
        self.fName = fName
        self.phone = phone
        self.lName = lName
        self.mailId = mailId
        self.address = address
        self.gender = gender
        self.dob = dob
    }
}
