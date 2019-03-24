//
//  ItemPopup.swift
//  CoFace
//
//  Created by Timur Misharin on 24/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

protocol refresh: class {
    func refreshCollection()
}
class ItemPopup: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var re: refresh?
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var add: UIButton!
    var category: String!
    @IBOutlet weak var name: RoundTextField!
    @IBOutlet weak var image: UIButton!
    @IBAction func imageAction(_ sender: Any) {
        let imagePicketController = UIImagePickerController()
        imagePicketController.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            (action: UIAlertAction) in
            imagePicketController.sourceType = .camera
            self.present(imagePicketController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Galery", style: .default, handler: { (action:UIAlertAction) in
            imagePicketController.sourceType = .photoLibrary
            self.present(imagePicketController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func addAction(_ sender: Any) {
        bluredEffect()
        if whatEmpty(){
            BranchData.shared.addItem(category: category, item: ["name": name.text as Any], image: (image.imageView?.image)!) { check in
                if check != "no"{
                    self.re?.refreshCollection()
                    self.view.removeFromSuperview()
                }
                else{
                    sleep(1)
                }
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.isHidden = false
    }
    
    private func whatEmpty()->Bool{
        if image.currentImage != UIImage(named: "image"){
            if name.text != nil{
                return true
            }
            return false
        }
        return false
    }
    
    private func bluredEffect(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.tag = 5
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            image.setImage(pickedImage, for: .normal)
            image.layer.borderWidth = 10
            image.layer.borderColor = UIColor.black.cgColor
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
