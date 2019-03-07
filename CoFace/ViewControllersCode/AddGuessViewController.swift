//
//  AddGuessViewController.swift
//  CoFace
//
//  Created by Timur Misharin on 04/02/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class addGuessViewController: UIViewController, SourceProtocol {
    
    var userEmail: String!
    var ProtocolMess: String!
    var ImagePicker:  UIImagePickerController!
    @IBOutlet weak var BackgroundImage: UIImageView!
    @IBOutlet weak var FirstNameTextField: RoundTextField!
    @IBOutlet weak var LastNameTextFielld: RoundTextField!
    @IBOutlet weak var EyeMonitorLable: UILabel!
    @IBOutlet weak var EyeMonitorSwitch: UISwitch!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var WarningLable: UILabel!
    @IBOutlet weak var ImagePickButton: UIButton!
    @IBOutlet weak var FieldsView: UIView!
    @IBOutlet weak var OrderLable: UILabel!
    
    @IBAction func AddButtonAction(_ sender: Any) {
        if CheckWhatEmpty() {
            let firstName = FirstNameTextField.text
            let lastName =  LastNameTextFielld.text
            let eye = EyeMonitorSwitch.isOn
            let guest: [String : Any] = ["first name" : firstName!, "last name" : lastName!, "eye" : eye]
            BranchData.shared.addGuest(guest: guest, image: ImagePickButton.currentImage!)
        self.navigationController?.popViewController(animated: true)
        }
        else{
            WarningLable.isEnabled = true
        }
    }
    
    
    @IBAction func ImagePickAction(_ sender: Any) {
        ShowPopup()
        GetImage()
        ImagePickSetup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BackgroundSetup()
        ImagePickSetup()
        WrningSetup()
        //print("userid in aggGuest", userid)
    }
    
    private func WrningSetup(){
        WarningLable.textColor = UIColor.red
        WarningLable.isHidden = true
    }
    private func BackgroundSetup(){
        BackgroundImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    private func WarningLableSetup(){
        WarningLable.textColor = UIColor.red
    }
    
    private func ImagePickSetup(){
        ImagePickButton.layer.cornerRadius = 0.5 * ImagePickButton.bounds.size.width
        ImagePickButton.clipsToBounds = true
        ImagePickButton.backgroundColor =  UIColor.clear
    }
    
    private func ViewsSetup(){
        OrderLable.layer.cornerRadius = 20
        FieldsView.layer.cornerRadius = 20
    }
    
    private func ShowPopup(){
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUp") as! PopUpViewController
        popOverVC.ProtocolMess = self
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    private func CheckWhatEmpty() -> Bool{
        WarningLable.text = "The next field can't be empty: \n"
        if (FirstNameTextField.text?.isEmpty)!{
           WarningLable.text?.append(contentsOf: " * First Name \n")
            if (LastNameTextFielld.text?.isEmpty)! {
                WarningLable.text?.append(contentsOf: " * Last Name \n")
                return false
            }
            return false
        }
        return true
    }
    
    private func GetImage(){
        print("mess", ProtocolMess)
        if ProtocolMess == "galery"{
            GetGaleryImage()
        }
        else{
            GetCameraImage()
        }
    }
    
    private func GetGaleryImage(){
        ImagePicker = UIImagePickerController()
        ImagePicker.allowsEditing = true
        ImagePicker.sourceType = .photoLibrary
        ImagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        openImagePicker()
    }
    
    private func GetCameraImage(){
        
    }
    
    private func openImagePicker(){
        self.present(ImagePicker, animated: true, completion: nil)
    }
    
    func didChose(source: String){
        ProtocolMess = source
        GetImage()
    }
    
    func UploadProfileImage(){
        //let StorageRef =  Storage.storage().reference().child("users/
    }
}

extension addGuessViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
             ImagePickButton.setImage(pickedImage, for: .normal)
            ImagePickButton.layer.borderWidth = 10
            ImagePickButton.layer.borderColor = UIColor.black.cgColor
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
