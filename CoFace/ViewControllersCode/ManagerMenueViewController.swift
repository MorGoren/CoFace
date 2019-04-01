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
    @IBOutlet weak var startButton: UIButton!
    @IBAction func startAction(_ sender: Any) {
        startButton.pulseAnimation()
    }
    
    @IBAction func menuAction(_ sender: Any) {
        menuButton.pulseAnimation()
    }
    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var guestButton: UIButton!
    @IBAction func guestAction(_ sender: Any) {
        guestButton.pulseAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BackgroundSetup()
        startButton.threeDButton()
        menuButton.threeDButton()
        guestButton.threeDButton()
    }
    
    private func BackgroundSetup(){
        BackgroundImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}
