//
//  CollectionFlowLayout.swift
//  CoFace
//
//  Created by Timur Misharin on 04/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class CollectionFlowLayout: UICollectionViewFlowLayout {
    
    var numberOfItem: CGFloat!
    
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
            let numberofColumns: CGFloat = numberOfItem
            let itemWidth = (self.collectionView!.frame.width - (numberofColumns)) / numberofColumns
            let itemHeight = (self.collectionView!.frame.width - (numberofColumns)) / numberofColumns
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    func setUpLayout(){
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
}
