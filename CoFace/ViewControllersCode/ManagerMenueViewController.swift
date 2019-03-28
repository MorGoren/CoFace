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
    override func viewDidLoad() {
        super.viewDidLoad()
        BackgroundSetup()
        //BranchData.shared.loadMyItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //BranchData.shared.loadMyItems()
    }
    
    private func BackgroundSetup(){
        BackgroundImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}
