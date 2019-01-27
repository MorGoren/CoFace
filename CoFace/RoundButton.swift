//
//  RoundButton.swift
//  CoFace
//
//  Created by Timur Misharin on 26/01/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class RoundButton: UIButton{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 4/UIScreen.main.nativeScale
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/2
        layer.borderColor = isEnabled ? tintColor.cgColor : UIColor.lightGray.cgColor
        layer.backgroundColor = isEnabled ? UIColor.white.cgColor : UIColor.clear.cgColor
    }
}


