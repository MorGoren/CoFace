//
//  CategoryPopup.swift
//  CoFace
//
//  Created by Timur Misharin on 13/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

protocol refreshCollection {
    func refresh()
}
class CategoryPopup: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var cat = BranchData.shared.categoryList
    var re : refreshCollection?

    @IBAction func cancelAction(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    @IBOutlet weak var categoryButton: UIButton!
    @IBAction func ImageAction(_ sender: Any) {
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
    
    @IBOutlet weak var categoryName: RoundTextField!
    @IBOutlet weak var add: UIButton!
    @IBAction func addAction(_ sender: Any) {
        bluredEffect()
        if checkWhatEmpty() {
            let new = ["name": categoryName.text]
            BranchData.shared.addCategoryList(category: new as [String : Any], image: categoryButton.currentImage! , completion: {check in
                if check != "no"{
                    self.re?.refresh()
                    self.view.removeFromSuperview()
                }
                else{
                    sleep(1)
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Setup()
    }
    
    private func Setup(){
        add.frame.size = CGSize(width: 50, height: 50)
    }
    
    private func bluredEffect(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.tag = 5
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    private func checkWhatEmpty()-> Bool{
        if categoryName != nil{
            if categoryButton.imageView?.image != UIImage(named: "image"){
                return true
            }
            return false
        }
        return false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            categoryButton.setImage(pickedImage, for: .normal)
            categoryButton.layer.borderWidth = 10
            categoryButton.layer.borderColor = UIColor.black.cgColor
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
