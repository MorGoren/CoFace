//
//  CategoryUICell.swift
//  CoFace
//
//  Created by Timur Misharin on 13/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

protocol categoryProtocol: class {
    func deleteCat(cell: CategoryUICell)
}

class CategoryUICell: UICollectionViewCell {
    
    //@IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    var cid: String!
    var image: String!
    weak var action: categoryProtocol?
    
    @IBAction func deleteAction(_ sender: Any) {
        action?.deleteCat(cell: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        deleteButton.frame.size = CGSize(width: 30, height: 30)
        self.cid = nil
        self.image = nil
        self.categoryLabel.text = nil
        self.categoryImage.image = nil
    }
}
