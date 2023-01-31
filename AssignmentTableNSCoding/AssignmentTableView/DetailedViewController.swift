//
//  DetailedViewController.swift
//  AssignmentTableView
//
//  Created by Abhilash k George on 09/01/22.
//

import UIKit

protocol PassDataToVcDelegate {
    func passData(image: UIImage, fName: String, lName: String, gender: String, mailId: String, address: String, DOB: String)
}

class DetailedViewController: UIViewController {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var fNameTxt: UITextField?
    @IBOutlet weak var genderLbl: UITextField?
    @IBOutlet weak var lNameTxt: UITextField?
    @IBOutlet weak var mailIdTxt: UITextField?
    @IBOutlet weak var addressTxt: UITextField?
    @IBOutlet weak var dobTxt: UITextField?
    var profileImage: UIImage?
    var fName = ""
    var lName = ""
    var gender = ""
    var mailId = ""
    var dob = ""
    var address = ""
    var submitDelegate: PassDataToVcDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic?.image = profileImage
        fNameTxt?.text = fName
        lNameTxt?.text = lName
        genderLbl?.text = gender
        mailIdTxt?.text = mailId
        dobTxt?.text = dob
        addressTxt?.text = address

    }
    @IBAction func didTapChange(_ sender: Any) {
        let image = UIImagePickerController()
        image.sourceType = .photoLibrary
        image.delegate = self
        image.allowsEditing = true
        present(image, animated: true, completion: nil)
    }

    @IBAction func submitTapped(_ sender: Any) {
        submitDelegate?.passData(image: (profilePic?.image)!, fName: fNameTxt?.text ?? "", lName: lNameTxt?.text ?? "", gender: genderLbl?.text ?? "", mailId: mailIdTxt?.text ?? "", address: addressTxt?.text ?? "", DOB: dobTxt?.text ?? "")
    }
    
    
}
extension DetailedViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            profilePic?.image = image
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
