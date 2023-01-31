//
//  ProfileList.swift
//  AssignmentTableView
//
//  Created by Abhilash k George on 18/01/22.
//

import UIKit

class ProfileList {
    
    var profiles: [Profiles] = [Profiles]()
    let dataStore = DataStore()
    init() {
        self.createArray()
    }
    func createArray(){
        
       // let loadProfiles = dataStore.loadProfiles()
        let data = dataStore.retreivedData

        
        if !data.isEmpty{
            for item in data {
                print("item")
                profiles.append(item)
                print(item)
            
            }
        }else {
            print("static data")
            // else load static data
            profiles.append(Profiles(image: UIImage(named: "1")!, fName: "John", lName: "", phone: "7624842110", gender: "Male",dob: "22 Jan 2000", mailId: "user@gmail.com", address: "Mangalore"))
            profiles.append(Profiles(image: UIImage(named: "32")! ,fName: "Christene ",lName: "",phone: "9485265441",gender: "Female",dob: "08 Feb 1998",mailId: "christene@gmail.com", address: "Bangalore"))
            profiles.append(Profiles(image: UIImage(named: "72")! , fName: "Emma", lName: "", phone: "9231215565", gender: "Female",dob: "23 Jul 2002", mailId: "emma@gmail.com", address: "Puttur"))
            profiles.append(Profiles(image: UIImage(named: "62")! , fName: "Richard",lName: "", phone: "9254266004", gender: "Male",dob: "02 Jan 1968", mailId: "richard3432@gmail.com", address: "Canada"))
            profiles.append(Profiles(image: UIImage(named: "30")! ,fName: "Caroline", lName: "", phone: "9254266005", gender: "Female",dob: "30 Jan 2004", mailId: "caroline@gmail.com", address: "Udupi"))
            //print(profiles)
           // saveProfiles()
            
            
        }
        
    }
    
    
    func saveProfiles() {
        print(("data is being saved"))
        print(profiles)
        dataStore.saveProfiles(profiles: profiles)

            
        }
   
        
        

}
