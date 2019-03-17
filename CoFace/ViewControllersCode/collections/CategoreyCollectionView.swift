//
//  ctegoreyCollectionView.swift
//  CoFace
//
//  Created by Timur Misharin on 13/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class CategoryCollectionView: UIViewController, UICollectionViewDataSource{
    
    var categories : [categoryData]!
    var flowLayout: CollectionFlowLayout!
    @IBOutlet weak var addOption: UIButton!
    @IBOutlet weak var collection: UICollectionView!
    @IBAction func addAction(_ sender: Any) {
        ShowPopup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Setup()
        flowLayout = CollectionFlowLayout()
        collection.collectionViewLayout = flowLayout
        categories = BranchData.shared.category
        collection?.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collection?.reloadData()
        super.viewWillAppear(animated)
    }
    
    private func ShowPopup(){
        let popOverVC = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "CategoryPopup") as! CategoryPopup
        //popOverVC.ProtocolMess = self
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    private func Setup(){
        addOption.frame.size = CGSize(width: 100, height: 100)
    }
    
    private func setCellImage(category: String) -> String{
        let cat = BranchData.shared.categoryList
        var answer = "delete"
        switch category{
            case cat[3]: answer = "fruit"
            case cat[2]: answer = "snacks"
            case cat[1]: answer = "cup"
            case cat[0]: answer = "food"
            default:
            break
        }
        return answer
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryUICell
        cell.layer.borderColor = UIColor.brown.cgColor
        cell.layer.borderWidth = 1
        let index = indexPath.row
        cell.cid = categories[index].cid
        if cell.cid != nil {
            cell.categoryLabel.text = categories[index].name
            cell.categoryButton.setImage(UIImage(named: setCellImage(category: cell.categoryLabel.text!))?.withRenderingMode(.alwaysOriginal), for: .normal)
            cell.delete = self
        }
        return cell
    }
}

extension CategoryCollectionView: categoryDelete {
    func deleteCat(cell: CategoryUICell) {
        print(collection?.indexPath(for: cell))
        if let index = collection?.indexPath(for: cell){
            BranchData.shared.removeCategory(cid: cell.cid)
            categories.remove(at: index.row)
            collection?.reloadData()
        }
    }
}
