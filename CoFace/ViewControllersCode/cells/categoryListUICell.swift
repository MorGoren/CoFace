//
//  categoryListUICell.swift
//  CoFace
//
//  Created by Timur Misharin on 18/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

protocol back {
    func goBack()
}
class categoryListUICell: UICollectionViewCell {
    
    var go : back?
    var imageURL: String!
    @IBOutlet weak var image: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBAction func addAction(_ sender: Any) {
        let category = ["name": self.label.text, "photoURL": imageURL]
        BranchData.shared.addCategory(category: category as [String : Any]) { check in
            if check != "no"{
                print("success")
                self.go?.goBack()
            }
            else{
                print("fail")
            }
        }
    }
    
    var cid: String!
        
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cid = nil
        self.label.text = nil
        self.image.imageView?.image = nil
    }
}
