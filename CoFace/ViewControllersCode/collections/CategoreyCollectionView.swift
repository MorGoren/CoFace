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
    var font: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFont()
        add = addButton()
        self.view.addSubview(add)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        background.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        collection.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collection.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        collection.bottomAnchor.constraint(equalTo: add.topAnchor).isActive = true
        flowLayout = CollectionFlowLayout()
        flowLayout.numberOfItem = 2
        collection.frame = CGRect(x: frame.minY, y: frame.minY+150, width: frame.width, height: frame.height)
        collection.collectionViewLayout = flowLayout
        categories = BranchData.shared.myCategories
        collection?.reloadData()
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
        cell.addSubview(cell.categoryImage)
        cell.addSubview(cell.categoryLabel)
        cell.addSubview(cell.deleteButton)
        cell.sendSubviewToBack(cell.categoryImage)
        cell.bringSubviewToFront(cell.deleteButton)
        cell.deleteButton.translatesAutoresizingMaskIntoConstraints = false
        cell.categoryImage.translatesAutoresizingMaskIntoConstraints = false
        cell.categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.categoryImage.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        cell.categoryImage.heightAnchor.constraint(equalToConstant: cell.frame.height*0.9).isActive = true
        cell.categoryImage.widthAnchor.constraint(equalToConstant: cell.frame.width).isActive = true
        cell.categoryLabel.topAnchor.constraint(equalTo: cell.categoryImage.bottomAnchor).isActive = true
        cell.categoryLabel.widthAnchor.constraint(equalToConstant: cell.frame.width).isActive = true
        cell.categoryLabel.heightAnchor.constraint(equalToConstant: cell.frame.height*0.1).isActive = true
        cell.categoryLabel.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        cell.categoryLabel.textAlignment = .center
        cell.deleteButton.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        cell.categoryLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(font))
        cell.deleteButton.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        cell.deleteButton.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
        cell.deleteButton.widthAnchor.constraint(equalToConstant: cell.frame.width/8).isActive = true
        cell.deleteButton.heightAnchor.constraint(equalToConstant: cell.frame.width/8).isActive = true
        cell.deleteButton.layer.cornerRadius = cell.deleteButton.frame.height/2
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
    
    private func setFont(){
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            font = 15
        case .pad:
            font = 25
        case .unspecified:
            font = 25
        case .tv:
            font = 25
        case .carPlay:
            font = 15
        @unknown default:
            font = 25
        }
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
