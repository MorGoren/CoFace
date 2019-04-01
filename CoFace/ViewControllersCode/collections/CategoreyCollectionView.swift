//
//  ctegoreyCollectionView.swift
//  CoFace
//
//  Created by Timur Misharin on 13/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit
import SDWebImage

class CategoryCollectionView: UIViewController, UICollectionViewDataSource{
    
    var categories : [itemData]!
    var flowLayout: CollectionFlowLayout!
    //var categoryItems: String!
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flowLayout = CollectionFlowLayout()
        flowLayout.numberOfItem = 2
        collection.collectionViewLayout = flowLayout
        categories = BranchData.shared.myCategories
        collection?.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categories = BranchData.shared.myCategories
        collection?.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemSegue" {
            let destinationVC = segue.destination as! ItemCollectionView
            let cell = sender as! CategoryUICell
            destinationVC.cid = cell.cid
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryUICell
        cell.layer.borderColor = UIColor.brown.cgColor
        cell.layer.borderWidth = 1
        let index = indexPath.row
        cell.cid = categories[index].id
        if cell.cid != nil {
            cell.categoryLabel.text = categories[index].name
            cell.image = categories[index].image
            
            cell.categoryImage.sd_setImage(with: URL(string: cell.image), placeholderImage: UIImage(named: "image")!)
            cell.action = self
        }
        return cell
    }
}

extension CategoryCollectionView: categoryProtocol {
    
    func deleteCat(cell: CategoryUICell) {
        if let index = collection?.indexPath(for: cell){
            BranchData.shared.removeCategory(cid: cell.cid)
            categories.remove(at: index.row)
            collection?.reloadData()
        }
    }
}
