//
//  CategoryUICell.swift
//  CoFace
//
//  Created by Timur Misharin on 13/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

protocol categoryDelete: class {
    func deleteCat(cell: CategoryUICell)
}

class CategoryUICell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    var cid: String!
    weak var delete: categoryDelete?
    
    @IBAction func deleteAction(_ sender: Any) {
        delete?.deleteCat(cell: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        deleteButton.frame.size = CGSize(width: 30, height: 30)
        self.cid = nil
        self.categoryLabel.text = nil
        self.categoryButton.imageView?.image = nil
    }
    
    func printCell(){
        print("category cell:", "name", self.categoryLabel.text!, "id", self.cid)
    }
}
