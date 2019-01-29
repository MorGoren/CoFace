//
//  RoundTextField.swift
//  CoFace
//
//  Created by Timur Misharin on 27/01/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class RoundTextField : UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 1/UIScreen.main.nativeScale
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/2
        layer.borderColor = UIColor.white.cgColor
        layer.backgroundColor = UIColor.clear.cgColor
    }
}
