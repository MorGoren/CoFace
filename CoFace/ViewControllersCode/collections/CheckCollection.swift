//
//  CheckCollection.swift
//  CoFace
//
//  Created by User on 28/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class CheckCollection: UIViewController, UICollectionViewDataSource {
    
    var arrayImages = [itemData]()
    var id: String!
    var imageLayout: CollectionFlowLayout!
    @IBOutlet weak var collection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayImages = BranchData.shared.myItems[id] ?? []
        print(arrayImages)
        collection?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CheckCell
        let url = URL(string: arrayImages[indexPath.row].image)
        cell.layer.borderColor = UIColor.brown.cgColor
        cell.layer.borderWidth = 1
        cell.image.sd_setBackgroundImage(with: url, for: .normal, completed: nil)
        return cell
    }
    
    
}
