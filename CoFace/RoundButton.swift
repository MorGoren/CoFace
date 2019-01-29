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
        layer.cornerRadius = frame.height/2
    }
    
    func changeLook(bool: Bool){
        if(!bool){
            firstLook()
        }
        if(bool){
            secondLook()
        }
    }
    
    private func firstLook(){
        layer.borderColor = UIColor.white.cgColor
        layer.backgroundColor = tintColor.cgColor
        setTitleColor(UIColor.white, for: .normal)
    }
    
    private func secondLook(){
        layer.borderColor = tintColor.cgColor
        layer.backgroundColor = UIColor.white.cgColor
        setTitleColor( self.tintColor, for: .normal)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}


