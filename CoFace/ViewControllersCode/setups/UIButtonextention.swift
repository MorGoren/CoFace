//
//  UIButtonextention.swift
//  CoFace
//
//  Created by Timur Misharin on 31/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    func threeDButton(){
        self.layer.cornerRadius = self.frame.height / 2;
        self.layer.borderWidth = 2.0;
        self.layer.borderColor = UIColor.clear.cgColor;
        self.layer.shadowColor = UIColor(red: 100.0/255.0, green:0.0, blue:0.0,alpha:1.0).cgColor;
        self.layer.shadowOpacity = 1.0;
        self.layer.shadowRadius = 1.0;
        self.layer.shadowOffset = CGSize(width: 0, height: 3);
    }
    
    func pulseAnimation(){
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.80
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        layer.add(pulse, forKey: nil)
    }
}
