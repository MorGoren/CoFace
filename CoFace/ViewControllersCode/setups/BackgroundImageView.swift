//
//  BackgroundImageView.swift
//  CoFace
//
//  Created by Timur Misharin on 13/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class BackgroundImageView: UIImageView{
    
    override init(image: UIImage?) {
        super.init(image: image)
        let screen = UIScreen.main.bounds
        self.frame.size = CGSize(width: screen.width, height: screen.height)
        self.center = CGPoint(x: 0, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
