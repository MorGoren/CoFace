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
    var cancel: UIButton!
    var add: UIButton!
    var category: String!
    var order: UILabel!
    var name: UITextField!
    var image: UIButton!
    var popup: UIView!
    var frame = UIScreen.main.bounds
    
    @objc func imageAction() {
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
    
    @objc func addAction() {
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
    
    @objc func cancelAction() {
        self.view.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let x = frame.maxX/3
        var y = frame.maxX/3
        var width = y
        let height = 1.2*width
        popup = UIView(frame: CGRect(x: frame.maxX/3, y: frame.maxY/3, width: width, height: height))
        popup.backgroundColor = UIColor.init(red: 253, green: 185, blue: 40, alpha: 0.80)
        order = addLabel(text: "הקש לבחירת תמונה", place: CGRect(x: x, y: 1.3*y+height/10, width: width, height: height/20), font: 15)
        order.textAlignment = .center
        image = addButton(name: "image", place: CGRect(x: x, y: 1.3*y+height/20, width: width, height: height/2))
        image.addTarget(self, action: #selector(imageAction), for: .touchUpInside)
        y = image.frame.maxY
        name = addTextField(fontSize: 15, placeholder: "פריט חדש", secure: false, place: CGRect(x: x, y: y, width: width, height: height/15))
        y = y+height/10
        width = height/5
        add = addRoundButton(name: "add", place: CGRect(x: popup.frame.maxX-width, y: y, width: width, height: width))
        add.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        cancel = addRoundButton(name: "delete", place: CGRect(x: popup.frame.minX, y: y, width: width, height: width))
        cancel.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        popup.layer.cornerRadius = 20
        self.view.addSubview(popup)
        self.view.addSubview(image)
        self.view.addSubview(order)
        self.view.addSubview(name)
        self.view.addSubview(add)
        self.view.addSubview(cancel)
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
    
    private func addLabel(text: String, place: CGRect, font: Int) -> UILabel{
        let label = UILabel(frame: place)
        label.text = text
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: CGFloat(font))
        label.backgroundColor = UIColor.init(
            white: CGFloat(1.0), alpha: CGFloat(0.80))
        label.layer.cornerRadius = label.frame.height/2
        return label
    }
    
    private func addButton(name: String, place: CGRect) -> UIButton{
        let button = UIButton(frame: place)
        button.setImage(UIImage(named: name), for: .normal)
        button.backgroundColor = .clear
        return button
    }
    private func addRoundButton(name: String, place: CGRect) -> UIButton{
        let button = UIButton(frame: place)
        button.setImage(UIImage(named: name), for: .normal)
        button.layer.cornerRadius = button.frame.size.height/2
        button.backgroundColor = .clear
        return button
    }
    
    private func addTextField(fontSize: Float, placeholder: String , secure: Bool, place: CGRect) -> UITextField{
        let textField =  UITextField(frame: place)
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.textAlignment = .right
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.isSecureTextEntry = secure
        textField.tag = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textColor = .black
        textField.backgroundColor = UIColor.init(
            white: CGFloat(1.0), alpha: CGFloat(0.56))
        return textField
    }

}
