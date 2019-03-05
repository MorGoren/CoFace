//
//  UICell.swift
//  CoFace
//
//  Created by Timur Misharin on 04/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class UICell: UICollectionViewCell {
    
    var cid: String!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var eyeImage: UIImageView!
    
    @IBAction func trashButton(_ sender: Any) {
    }
    @IBAction func editButton(_ sender: Any) {
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image = nil
        firstNameLabel = nil
        lastNameLabel = nil
        eyeImage = nil
    }
}
