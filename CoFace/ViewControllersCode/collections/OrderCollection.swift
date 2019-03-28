//
//  OrderCollection.swift
//  CoFace
//
//  Created by User on 25/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class OrderCollection: UIViewController, UICollectionViewDataSource{
    
    
    var arrayImages = [categoryData]()
    var imageLayout: CollectionFlowLayout!
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLayout = CollectionFlowLayout()
        imageLayout.numberOfItem = 2
        collection.collectionViewLayout = imageLayout
        arrayImages = BranchData.shared.myCategories
        collection?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OrderCell
        let url = URL(string: arrayImages[indexPath.row].image)
        cell.layer.borderColor = UIColor.brown.cgColor
        cell.layer.borderWidth = 1
        cell.image.sd_setImage(with: url, placeholderImage:UIImage(named: "image")
        )
        cell.itemID = arrayImages[indexPath.row].cid
        return cell
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "orderSegue" {
            let destinationVC = segue.destination as! CheckCollection
            let cell = sender as! OrderCell
            print("first id", cell.itemID)
            destinationVC.id = cell.itemID
        }
    }
}
