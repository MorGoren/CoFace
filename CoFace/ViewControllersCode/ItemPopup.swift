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
    var cancel = UIButton()
    var add = UIButton()
    var category = String()
    var order = UILabel()
    var name = UITextField()
    var image =  UIButton()
    var popup = UIView()
    var frame = UIScreen.main.bounds
    var font: Int!
    
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
        setFont()
        var width = frame.width/2
        let height = 1.2*width
        popup.backgroundColor = UIColor.init(white: 1.0, alpha: 0.8)
        popup.layer.cornerRadius = 20
        self.view.addSubview(popup)
        self.popup.addSubview(order)
        self.popup.addSubview(image)
        self.popup.addSubview(name)
        self.popup.addSubview(add)
        self.popup.addSubview(cancel)
        popup.translatesAutoresizingMaskIntoConstraints = false
        popup.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popup.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        popup.widthAnchor.constraint(equalToConstant: width).isActive = true
        popup.heightAnchor.constraint(equalToConstant: height).isActive = true
        order.translatesAutoresizingMaskIntoConstraints = false
        order.topAnchor.constraint(equalTo: popup.topAnchor).isActive = true
        order.widthAnchor.constraint(equalToConstant: width).isActive = true
        order.heightAnchor.constraint(equalToConstant: height/20).isActive = true
        order.text = "הקש לבחירת תמונה"
        order.textColor = .black
        order.backgroundColor = .clear
        order.font = UIFont.boldSystemFont(ofSize: CGFloat(font))
        order.textAlignment = .center
        image.setImage(UIImage(named: "image"), for: .normal)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.topAnchor.constraint(equalTo: order.bottomAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: width).isActive = true
        image.heightAnchor.constraint(equalToConstant: height/2).isActive = true
        image.addTarget(self, action: #selector(imageAction), for: .touchUpInside)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: height/20).isActive = true
        name.placeholder = "שם פריט"
        name.font = UIFont.boldSystemFont(ofSize: CGFloat(font))
        name.widthAnchor.constraint(equalTo: popup.widthAnchor).isActive = true
        name.heightAnchor.constraint(equalToConstant: height/10)
        name.textAlignment = .right
        add.setImage(UIImage(named: "add"), for: .normal)
        width = width/4
        add.translatesAutoresizingMaskIntoConstraints = false
        add.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        add.widthAnchor.constraint(equalToConstant: width).isActive = true
        add.heightAnchor.constraint(equalToConstant: width).isActive = true
        add.rightAnchor.constraint(equalTo: name.rightAnchor).isActive = true
        add.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        cancel.setImage(UIImage(named: "delete"), for: .normal)
        cancel.translatesAutoresizingMaskIntoConstraints = false
        cancel.topAnchor.constraint(equalTo: add.topAnchor).isActive = true
        cancel.widthAnchor.constraint(equalToConstant: width).isActive = true
        cancel.heightAnchor.constraint(equalToConstant: width).isActive = true
        cancel.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
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
    
    private func setFont(){
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            font = 15
        case .pad:
            font = 25
        case .unspecified:
            font = 25
        case .tv:
            font = 25
        case .carPlay:
            font = 15
        @unknown default:
            font = 25
        }
    }

}
