//
//  ItemCollectionView.swift
//  CoFace
//
//  Created by Timur Misharin on 24/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class ItemCollectionView: UIViewController, UICollectionViewDataSource {

    var cid: String!
    var items: [itemData]!
    var flowLayout: CollectionFlowLayout!
    @IBOutlet weak var collection: UICollectionView!
    @IBAction func addItem(_ sender: Any) {
        ShowPopup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flowLayout = CollectionFlowLayout()
        flowLayout.numberOfItem = 2
        collection.collectionViewLayout = flowLayout
        items = BranchData.shared.myItems[cid]
        print("my cid is", cid)
        print("my items are", items)
        collection?.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        items = BranchData.shared.myItems[cid]
        collection?.reloadData()
    }
    private func ShowPopup(){
        let popOverVC = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "ItemPopup") as! ItemPopup
        popOverVC.category = cid
        popOverVC.re = self
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ItemUICell
        cell.layer.borderColor = UIColor.brown.cgColor
        cell.layer.borderWidth = 1
        let index = indexPath.row
        cell.id = items[index].id
        if cell.id != nil {
            cell.itemLabel.text = items[index].name
            cell.imageURL = items[index].image
            
            cell.itemImage.sd_setImage(with: URL(string: cell.imageURL), placeholderImage: UIImage(named: "image")!)
            cell.delete = self
            //cell.action = self
        }
        return cell
    }
}

extension ItemCollectionView: refresh, cellDelete{
    func delete(cell: ItemUICell) {
        if let index = collection?.indexPath(for: cell){
            let path = "Items/\(cid ?? "defult")/\(cell.id ?? "defult")"
            print("my path", path)
            print("my imageURL", cell.imageURL)
            BranchData.shared.removeItem(path: path, url: cell.imageURL)
            items.remove(at: index.row)
            collection?.reloadData()
        }
    }
    
    func refreshCollection() {
         items = BranchData.shared.myItems[cid]
         collection.reloadData()
    }
    
}
