//
//  PictureCollection.swift
//  CoFace
//
//  Created by User on 25/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class PictureCollection: UIViewController, UICollectionViewDataSource,removePhoto {
    
    
    var arrayImages = [guestData]()
    var imageLayout: CollectionFlowLayout!
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLayout = CollectionFlowLayout()
        imageLayout.numberOfItem = 2
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
        //print("url here", url)
        cell.image.sd_setImage(with: url, placeholderImage:UIImage(named: "profile"))
        cell.id = arrayImages[indexPath.row].cid
        //cell.image.frame.size = CGSize(
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pictureSegue" {
            let destinationVC = segue.destination as! OrderCollection
            let cell = sender as! PictureCell
            destinationVC.order = cell.id
            destinationVC.index = findIndex(id: cell.id)
            destinationVC.re = self
        }
    }
    
    func remove(index: Int) {
        arrayImages.remove(at: index)
        collection?.reloadData()
    }
    
    private func findIndex(id: String)-> Int{
        var i = 0
        while arrayImages[i].cid != id{
            i+=1
        }
        return i
    }
}
