//
//  ManagerMenueViewController.swift
//  CoFace
//
//  Created by Timur Misharin on 05/02/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit
import Firebase

class ManagerMenue: UIViewController {

    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var BackgroundImage: UIImageView!
    @objc func startAction() {
        activity.pulseAnimation()
        performSegue(withIdentifier: "start", sender: self)
    }
    
    @objc func menuAction() {
        menu.pulseAnimation()
        performSegue(withIdentifier: "menu", sender: self)
    }
    
    @objc func guestAction() {
        guest.pulseAnimation()
        performSegue(withIdentifier: "guest", sender: self)
    }
    
    @objc func logout(){
        try! Auth.auth().signOut()
        self.view.removeFromSuperview()
        let MainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let MainNavigationVC = MainStoryboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
            else{return}
        //MainNavigationVC.topViewController
        present(MainNavigationVC, animated: true, completion: nil)
    }
    
    var activity = UIButton()
    var menu = UIButton()
    var guest =  UIButton()
    var acLabel = UILabel()
    var meLabel =  UILabel()
    var guLabel = UILabel()
    var font: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        setFont()
        let frame = UIScreen.main.bounds
        let size = frame.height/6
        //activity = addButton(name: "restaurantIcon", place: CGRect(x: x, y: CGFloat(y), width: CGFloat(size), height: CGFloat(size)))
        self.view.addSubview(activity)
        self.view.addSubview(acLabel)
        self.view.addSubview(menu)
        self.view.addSubview(meLabel)
        self.view.addSubview(guLabel)
        self.view.addSubview(guest)
        activity.setImage(UIImage(named: "restaurantIcon"), for: .normal)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        activity.widthAnchor.constraint(equalToConstant: size).isActive = true
        activity.heightAnchor.constraint(equalToConstant: size).isActive = true
        //self.navigationItem.titleView!.bottomAnchor
        activity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        acLabel.text = "התחל פעילות"
        acLabel.textAlignment = .center
        acLabel.textColor = .black
        acLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(font))
        acLabel.textColor = UIColor.black
        acLabel.textAlignment = .center
        acLabel.translatesAutoresizingMaskIntoConstraints = false
        acLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        acLabel.topAnchor.constraint(equalTo: activity.bottomAnchor).isActive = true
        acLabel.widthAnchor.constraint(equalToConstant: 1.5*size).isActive = true
        acLabel.heightAnchor.constraint(equalToConstant: 0.2*size).isActive = true
        acLabel.layer.cornerRadius = 20
        menu.setImage(UIImage(named: "menuIcon"), for: .normal)
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        menu.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        menu.widthAnchor.constraint(equalToConstant: size).isActive = true
        menu.heightAnchor.constraint(equalToConstant: size).isActive = true
        meLabel.text = "תפריט"
        meLabel.textAlignment = .center
        meLabel.textColor = .black
        meLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(font))
        meLabel.textColor = UIColor.black
        meLabel.textAlignment = .center
        meLabel.translatesAutoresizingMaskIntoConstraints = false
        meLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        meLabel.topAnchor.constraint(equalTo: menu.bottomAnchor).isActive = true
        meLabel.widthAnchor.constraint(equalToConstant: 1.5*size).isActive = true
        meLabel.heightAnchor.constraint(equalToConstant: 0.2*size).isActive = true
        meLabel.layer.cornerRadius = 20
        guLabel.text = "רשימת אורחים"
        guLabel.textAlignment = .center
        guLabel.textColor = .black
        guLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(font))
        guLabel.textColor = UIColor.black
        guLabel.textAlignment = .center
        guLabel.translatesAutoresizingMaskIntoConstraints = false
        guLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        guLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        guLabel.widthAnchor.constraint(equalToConstant: 1.5*size).isActive = true
        guLabel.heightAnchor.constraint(equalToConstant: 0.2*size).isActive = true
        guLabel.layer.cornerRadius = 20
        guest.setImage(UIImage(named: "guestlist"), for: .normal)
        guest.translatesAutoresizingMaskIntoConstraints = false
        guest.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        guest.bottomAnchor.constraint(equalTo: guLabel.topAnchor).isActive = true
        guest.widthAnchor.constraint(equalToConstant: size).isActive = true
        guest.heightAnchor.constraint(equalToConstant: size).isActive = true
        guLabel.textAlignment = .center
         activity.addTarget(self, action: #selector(startAction), for: .touchUpInside)
         menu.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
         guest.addTarget(self, action: #selector(guestAction), for: .touchUpInside)
         self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.isHidden = false
        BackgroundSetup()
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = .black
        self.navigationItem.title = "תפריט אפשרויות"
        let backButton = UIBarButtonItem()
        backButton.title = "אחורה"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        // navigation bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "התנתק", style: .plain, target: self, action: #selector(logout))
    }
    
    private func BackgroundSetup(){
        BackgroundImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
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
