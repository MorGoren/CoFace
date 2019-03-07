//
//  UICell.swift
//  CoFace
//
//  Created by Timur Misharin on 04/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

protocol cellDelegate: class{
    func delete(cell: UICell)
}
class UICell: UICollectionViewCell {
    
    var cid: String!
    var imageURL: URL!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var eyeImage: UIImageView!
    weak var delegate: cellDelegate?
    
    @IBAction func trashButton(_ sender: Any) {
            delegate?.delete(cell: self)
    }
    
    @IBAction func editButton(_ sender: Any) {
    
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image = nil
        self.firstNameLabel = nil
        self.lastNameLabel = nil
        self.eyeImage = nil
        self.cid = nil
        self.imageURL = nil
    }
}
