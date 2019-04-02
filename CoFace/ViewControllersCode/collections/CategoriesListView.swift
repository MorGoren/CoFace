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
    
    var categoriesList: [itemData]!
    var flowLayout: CollectionFlowLayout!
    let frame = UIScreen.main.bounds
    var add: UIButton!
    @IBOutlet weak var background: UIImageView!
    @objc func addAction() {
        ShowPopup()
    }
    @IBOutlet weak var collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
        backgroundSetup()
        flowLayout = CollectionFlowLayout()
        flowLayout.numberOfItem = 3
        collection.collectionViewLayout = flowLayout
        categoriesList = BranchData.shared.categoryList
        print("here is category list", categoriesList)
        collection?.reloadData()
        self.view.addSubview(addButton())
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
        cell.cid = categoriesList[index].id
        cell.go = self
        if cell.image != nil {
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
    
    private func addButton() -> UIButton{
        let y = frame.height/20
        let button = UIButton(frame: CGRect(x: frame.minX, y: frame.maxY-y, width: frame.width, height: y))
        button.setTitle("הוסף קטגוריה לתפריט", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25.0)
        button.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        button.layer.cornerRadius = button.frame.size.height / 2
        button.backgroundColor = UIColor.init(white: CGFloat(1.0), alpha: CGFloat(0.56))
        return button
    }

    
    private func backgroundSetup(){
        background.frame = CGRect(x: frame.minX, y: frame.minY+150, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
