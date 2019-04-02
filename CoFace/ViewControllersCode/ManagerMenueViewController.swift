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
    
    var activity: UIButton!
    var menu: UIButton!
    var guest: UIButton!
    var acLabel: UILabel!
    var meLabel: UILabel!
    var guLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = UIScreen.main.bounds
        let size = UIScreen.main.bounds.height/6
        let x = frame.midX - size/2
        var y = size/2
        activity = addButton(name: "restaurantIcon", place: CGRect(x: x, y: CGFloat(y), width: CGFloat(size), height: CGFloat(size)))
        let ly = size*1.1
        acLabel = addLabel(text: "התחל פעילות", place: CGRect(x: x, y: y+ly, width: size + 50, height: size/3))
        acLabel.textAlignment = .center
        y = 2.2*size
        menu = addButton(name: "menuIcon", place: CGRect(x: x, y: y, width: size, height: size))
        meLabel = addLabel(text: "תפריט", place: CGRect(x: x, y: y+ly , width: size, height: size/3))
        meLabel.textAlignment = .center
        y = 3.3*size
        guest = addButton(name: "guestlist", place: CGRect(x: x, y: y+0.5*ly, width: size, height: size))
        guLabel = addLabel(text: "רשימת אורחים", place: CGRect(x: x, y: y+1.5*ly, width: size*1.5, height: size/3))
        guLabel.textAlignment = .center
         activity.addTarget(self, action: #selector(startAction), for: .touchUpInside)
         menu.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
         guest.addTarget(self, action: #selector(guestAction), for: .touchUpInside)
        self.view.addSubview(activity)
        self.view.addSubview(acLabel)
        self.view.addSubview(menu)
        self.view.addSubview(meLabel)
        self.view.addSubview(guest)
        self.view.addSubview(guLabel)
         self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.isHidden = false
        BackgroundSetup()
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = .black
        self.navigationItem.title = "תפריט אפשרויות"
        let backButton = UIBarButtonItem()
        backButton.title = "אחורה"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func BackgroundSetup(){
        BackgroundImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    private func addButton(name: String, place: CGRect) -> UIButton{
        let button = UIButton(frame: place)
        button.setImage(UIImage(named: name), for: .normal)
        button.layer.cornerRadius = button.frame.size.height / 2
        button.backgroundColor = .clear
        return button
    }
    
    private func addLabel(text: String, place: CGRect) -> UILabel{
        let label = UILabel(frame: place)
        label.text = text
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: CGFloat(40))
        label.backgroundColor = UIColor.init(white: CGFloat(1.0), alpha: CGFloat(0.56))
        label.layer.cornerRadius = place.height/2
        return label
    }
}
