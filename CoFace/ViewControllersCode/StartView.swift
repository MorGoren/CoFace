//
//  StartView.swift
//  CoFace
//
//  Created by Timur Misharin on 31/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class StartView: UIViewController {

    @IBOutlet weak var takeOrder: UIButton!
    @IBAction func takeAction(_ sender: UIButton) {
        sender.pulseAnimation()
    }
    
    @IBOutlet weak var cookOrder: UIButton!
    @IBAction func cookAction(_ sender: UIButton) {
        sender.pulseAnimation()
    }
    
    @IBOutlet weak var orderReady: UIButton!
    @IBAction func readyAction(_ sender: UIButton) {
        sender.pulseAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        takeOrder.threeDButton()
        cookOrder.threeDButton()
        orderReady.threeDButton()
    }
}
