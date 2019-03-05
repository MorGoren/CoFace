//
//  CollectionFlowLayout.swift
//  CoFace
//
//  Created by Timur Misharin on 04/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class CollectionFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpLayout()
    }
    
    override var itemSize: CGSize{
        set {}
        get {
            let numberofColumns: CGFloat = 3
            let itemWidth = (self.collectionView!.frame.width - (numberofColumns - 1)) / numberofColumns
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
    func setUpLayout(){
        minimumInteritemSpacing = 20
        minimumLineSpacing = 20
        scrollDirection = .vertical
    }
}
