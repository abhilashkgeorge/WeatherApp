//
//  DataStore.swift
//  AssignmentTableView
//
//  Created by Abhilash k George on 18/01/22.
//

import Foundation
import UIKit

class DataStore {
    var retreivedData: [Profiles] = [Profiles]()
    let plistFileManger = FileManager.default
    
    
    func saveProfiles(profiles: [Any]) {
        // check if the plist file already exists
        guard let plistUrl = getPlistUrl() else { return}
        // If no file create
        if (!plistFileManger.fileExists(atPath: plistUrl.path)) {
            
            plistFileManger.createFile(atPath: plistUrl.path, contents: nil, attributes: nil  )
        }
        //store the data in the plist file
        do {
        let data = try NSKeyedArchiver.archivedData(withRootObject: profiles, requiringSecureCoding: false)
        try data.write(to: plistUrl)
            print("File created!!")
        }catch  {
            print("File creation failed!!")
        }
}
        

                
    
    func getPlistUrl() -> URL? {
        guard let url = plistFileManger.urls(for: .documentDirectory, in:  .userDomainMask).first else {
            return nil
        }
           
           let fileUrl = url.appendingPathComponent("ProfilePlist")
           try? plistFileManger.createDirectory(at: fileUrl, withIntermediateDirectories: true, attributes: nil)
           let plistUrl = fileUrl.appendingPathComponent("profile.plist")
           return plistUrl
       }
    
    func loadProfiles(){
        

        guard let plistUrl = getPlistUrl() else { return }
        if (plistFileManger.fileExists(atPath: plistUrl.path)) {
            do {
                        let data = try Data(contentsOf: plistUrl)
                        if let allProfiles = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Profiles] {
                        
                            retreivedData = allProfiles
                            print(retreivedData)
                        }
                    } catch {
                        print("error in loading")
                    }
    
    }

}
}

