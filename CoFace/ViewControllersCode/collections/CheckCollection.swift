//
//  CheckCollection.swift
//  CoFace
//
//  Created by User on 28/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

protocol returnItem: class{
    func item(cell: itemData, category: String)
}

class CheckCollection: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var arrayImages = [itemData]()
    var imageLayout: CollectionFlowLayout!
    var category: String!
    var prot: returnItem?
    @IBOutlet weak var collection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayImages = BranchData.shared.myItems[category] ?? []
        print(arrayImages)
        collection?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CheckCell
        let url = URL(string: arrayImages[indexPath.row].image)
        cell.frame.size.width = UIScreen.main.bounds.width / 2 
        cell.layer.borderColor = UIColor.brown.cgColor
        cell.layer.borderWidth = 1
        cell.image.sd_setImage(with: url, placeholderImage: UIImage(named: "image"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        prot?.item(cell: arrayImages[indexPath.row], category: category)
        self.navigationController?.popViewController(animated: true)
    }
    
}
