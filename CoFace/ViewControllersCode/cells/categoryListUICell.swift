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
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var addButton: UIButton!
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
        self.image = nil
        self.addButton.frame.size = CGSize(width: 50, height: 50)
    }
        
    func printCell(){
        print("category cell:", "name", self.label.text!, "id", self.cid)
    }
}
