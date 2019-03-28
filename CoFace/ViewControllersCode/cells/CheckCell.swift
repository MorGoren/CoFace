//
//  CheckCell.swift
//  CoFace
//
//  Created by User on 28/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

protocol returnOrder: class {
    func add(cell: CheckCell)
}

class CheckCell: UICollectionViewCell {
    @IBAction func checkOrder(_ sender: Any) {
        
    }
    @IBOutlet weak var image: UIButton!
    var id: String!
    var returnPro: returnOrder?
    override func prepareForReuse() {
        self.image = nil
        self.id = nil
    }
}
