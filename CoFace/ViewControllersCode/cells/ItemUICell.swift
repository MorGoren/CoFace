//
//  ItemUICell.swift
//  CoFace
//
//  Created by Timur Misharin on 24/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

protocol cellDelete: class {
    func delete(cell: ItemUICell)
}

class ItemUICell: UICollectionViewCell {
    
    @IBOutlet weak var delete: UIButton!
    var id: String!
    var deleteAc: cellDelete?
    var imageURL: String!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBAction func deleteAction(_ sender: Any) {
        deleteAc?.delete(cell: self)
    }
    
    override func prepareForReuse() {
        self.id = nil
        self.itemImage.image = nil
        self.itemLabel.text =  nil
    }
}
