//
//  CategoriesListView.swift
//  CoFace
//
//  Created by Timur Misharin on 18/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit
import SDWebImage

class CategoriesListView: UIViewController, UICollectionViewDataSource, refreshCollection, back{
    
    var categoriesList: [categoryData]!
    var flowLayout: CollectionFlowLayout!
    
    @IBAction func addAction(_ sender: Any) {
        ShowPopup()
    }
    
    @IBOutlet weak var collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        flowLayout = CollectionFlowLayout()
        flowLayout.numberOfItem = 3
        collection.collectionViewLayout = flowLayout
        categoriesList = BranchData.shared.categoryList
        print("here is category list", categoriesList)
        collection?.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        categoriesList = BranchData.shared.categoryList
        collection?.reloadData()
        super.viewWillAppear(animated)
    }
    
    private func ShowPopup(){
        let popOverVC = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "CategoryPopup") as! CategoryPopup
        //popOverVC.ProtocolMess = self
        popOverVC.re = self
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! categoryListUICell
        cell.layer.borderColor = UIColor.brown.cgColor
        cell.layer.borderWidth = 1
        let index = indexPath.row
        cell.cid = categoriesList[index].cid
        cell.go = self
        if cell.cid != nil {
            cell.label.text = categoriesList[index].name
            cell.addButton.frame.size = CGSize(width: 50, height: 50)
            print(cell.label.text as Any)
            cell.imageURL = categoriesList[index].image
            cell.image.sd_setImage(with: URL(string: cell.imageURL), placeholderImage: UIImage(named: "image")!)
        }
        return cell
    }
    
    func refresh(){
        categoriesList = BranchData.shared.categoryList
        collection.reloadData()
    }
    
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
