//
//  OrderToDoUICell.swift
//  CoFace
//
//  Created by Timur Misharin on 28/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class OrderToDoUICell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image = nil
    }
}
