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
    var add: UIButton!
    let frame = UIScreen.main.bounds
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var collection: UICollectionView!
    @objc func addItem() {
        ShowPopup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BackgroundSetup()
        collection.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
        flowLayout = CollectionFlowLayout()
        flowLayout.numberOfItem = 2
        collection.collectionViewLayout = flowLayout
        items = BranchData.shared.myItems[cid]
        print("my cid is", cid)
        print("my items are", items)
        add = addButton()
        collection?.reloadData()
        self.view.addSubview(add)
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
    
    private func addButton() -> UIButton{
        let y = frame.height/20
        let button = UIButton(frame: CGRect(x: frame.minX, y: frame.maxY-y, width: frame.width, height: y))
        button.setTitle("הוסף פריט לקטגוריה", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25.0)
        button.addTarget(self, action: #selector(addItem), for: .touchUpInside)
        button.layer.cornerRadius = button.frame.size.height / 2
        button.backgroundColor = UIColor.init(white: CGFloat(1.0), alpha: CGFloat(0.56))
        return button
    }
    
    private func BackgroundSetup(){
        background.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
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
