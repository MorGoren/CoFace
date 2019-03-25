//
//  PictureCollection.swift
//  CoFace
//
//  Created by User on 25/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class PictureCollection: UIViewController, UICollectionViewDataSource {
    
    var arrayImages = [guestData]()
    var imageLayout: CollectionFlowLayout!
    
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLayout = CollectionFlowLayout()
        imageLayout.numberOfItem = 3
        collection.collectionViewLayout = imageLayout
        arrayImages = BranchData.shared.guestInfo
        collection?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PictureCell
        let url = URL(string: arrayImages[indexPath.row].image)
        cell.layer.borderColor = UIColor.brown.cgColor
        cell.layer.borderWidth = 1 
        print("url here", url)
        cell.image.sd_setImage(with: url, placeholderImage:UIImage(named: "profile"))
        return cell
    }

}
