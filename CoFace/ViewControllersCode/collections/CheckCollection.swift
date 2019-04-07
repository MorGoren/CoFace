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
    
    @IBOutlet weak var background: UIImageView!
    var arrayImages = [itemData]()
    var flowLayout: CollectionFlowLayout!
    var category: String!
    var prot: returnItem?
    var frame = UIScreen.main.bounds
    @IBOutlet weak var collection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        background.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        collection.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collection.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        collection.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
        flowLayout = CollectionFlowLayout()
        flowLayout.numberOfItem = 2
        collection.collectionViewLayout = flowLayout
        arrayImages = BranchData.shared.myItems[category] ?? []
        print(arrayImages)
        collection?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CheckCell
        cell.image.translatesAutoresizingMaskIntoConstraints = false
        cell.image.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        cell.image.widthAnchor.constraint(equalTo: cell.widthAnchor).isActive = true
        cell.image.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
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
    
    private func BackgroundSetup(){
        background.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }

}
