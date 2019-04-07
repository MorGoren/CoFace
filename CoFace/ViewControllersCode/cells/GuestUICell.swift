//
//  UICell.swift
//  CoFace
//
//  Created by Timur Misharin on 04/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

protocol cellDeleteDelegate: class{
    func delete(cell: GuestUICell)
}
class GuestUICell: UICollectionViewCell {
    
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var trash: UIButton!
    var cid: String!
    var imageURL: URL!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var eyeImage: UIImageView!
    weak var delegateDelete: cellDeleteDelegate?
    
    @IBAction func trashButton(_ sender: Any) {
            delegateDelete?.delete(cell: self)
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
