//
//  ViewController.swift
//  AssignmentTableView
//
//  Created by Abhilash k George on 07/01/22.
//

import UIKit

class ViewController: UIViewController {
    var profileObj = ProfileList()
    
    @IBOutlet weak var profileListScreen: UITableView?
    var profile = [Profiles]()
    var indexMain = 0
    var indexes : [IndexPath] = []
    var ascendingSort: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        profile =  profileObj.profiles
        profileListScreen?.delegate = self
        profileListScreen?.dataSource = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddProfile))
        
    }
    //Mark: Sorting in ascending and descending order
   
  
    @objc func handleAddProfile()  {
       // var index = 0
        let newProfile = Profiles(image: UIImage(named: "dummy")! , fName: "", lName: "", phone: "", gender: "",dob: "", mailId: "", address: "")
        profile.append(newProfile)
        profileListScreen?.reloadData()
        profileObj.saveProfiles()
      
    
    }
    @IBAction func sortBtnTapped(_ sender: Any) {
        
        if ascendingSort == false {
            profile.sort(by: {$0.fName < $1.fName})
            ascendingSort = true
        } else {
            profile.sort(by: {$0.fName > $1.fName})
            ascendingSort = false
        }
        profileListScreen?.reloadData()
    }
// Mark: deleting Rows
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            profile.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            profileObj.saveProfiles()
            
        }
    }
    //
    override func viewWillAppear(_ animated: Bool) {
        profileListScreen?.reloadRows(at: indexes, with: .middle)
    }
    }
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profile = profile[indexPath.row]
        guard let detailedView = storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as? DetailedViewController else { return }
        detailedView.profileImage = profile.image
        detailedView.fName = profile.fName
        detailedView.lName = profile.lName
        detailedView.gender = profile.gender
        detailedView.mailId = profile.mailId
        detailedView.dob = profile.dob
        detailedView.address = profile.address
        
        detailedView.submitDelegate = self
        indexMain = indexPath.row
        indexes = [indexPath]
        navigationController?.pushViewController(detailedView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profile = profile[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileCell
        cell.setProfiles(profile: profile)
        return cell
    }
    
}

extension ViewController: PassDataToVcDelegate{
    func passData(image: UIImage, fName: String, lName: String, gender: String, mailId: String, address: String, DOB: String) {
        
        let profile = profile[indexMain]
        profile.image = image
        profile.fName = fName
        profile.lName = lName
        profile.gender = gender
        profile.mailId = mailId
        profile.address = address
        profile.dob = DOB
        profileObj.saveProfiles()
        

        navigationController?.popViewController(animated: true)
    }
    
}
