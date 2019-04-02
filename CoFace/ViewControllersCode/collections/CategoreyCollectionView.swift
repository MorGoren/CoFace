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
    
    @IBOutlet weak var background: UIImageView!
    var categories : [itemData]!
    var flowLayout: CollectionFlowLayout!
    @IBOutlet weak var collection: UICollectionView!
    let frame = UIScreen.main.bounds
    var add: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundSetup()
        add = addButton()
        flowLayout = CollectionFlowLayout()
        flowLayout.numberOfItem = 2
        collection.frame = CGRect(x: frame.minY, y: frame.minY+150, width: frame.width, height: frame.height)
        collection.collectionViewLayout = flowLayout
        categories = BranchData.shared.myCategories
        collection?.reloadData()
        self.view.addSubview(add)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categories = BranchData.shared.myCategories
        collection.frame = CGRect(x: frame.minX, y: frame.minY + 50, width: frame.width, height: frame.height)
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
    
    private func backgroundSetup(){
        background.frame = CGRect(x: frame.minX, y: frame.minY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    private func addButton() -> UIButton{
        let y = frame.height/20
        let button = UIButton(frame: CGRect(x: frame.minX, y: frame.maxY-y, width: frame.width, height: y))
        button.setTitle("הוסף קטגוריה לתפריט", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25.0)
        button.addTarget(self, action: #selector(categoryList), for: .touchUpInside)
        button.layer.cornerRadius = button.frame.size.height / 2
        button.backgroundColor = UIColor.init(white: CGFloat(1.0), alpha: CGFloat(0.56))
        return button
    }
    
    @objc func categoryList(){
        performSegue(withIdentifier: "categoryList", sender: self)
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
