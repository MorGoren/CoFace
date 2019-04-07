//
//  CheckCell.swift
//  CoFace
//
//  Created by User on 28/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class CheckCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    var id: String!
    var index: IndexPath!
    
    override func prepareForReuse() {
        self.image = nil
        self.id = nil
        self.index = nil
    }
}
