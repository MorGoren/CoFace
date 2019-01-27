//
//  ViewController.swift
//  CoFace
//
//  Created by Timur Misharin on 09/01/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var forwardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forwardButtonSetup()
        
    }
    private func forwardButtonSetup(){
        forwardButton.frame.size = CGSize(width: 50, height: 50)
    }

}

