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
    var font: Int!
    @IBOutlet weak var background: UIImageView!
    @objc func addAction() {
        ShowPopup()
    }
    @IBOutlet weak var collection: UICollectionView!
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
        collection.collectionViewLayout = flowLayout
        categoriesList = BranchData.shared.categoryList
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
        let index = indexPath.row
        cell.cid = categoriesList[index].id
        cell.go = self
        cell.label.text = categoriesList[index].name
        print(cell.label.text as Any)
        cell.imageURL = categoriesList[index].image
        cell.image.sd_setBackgroundImage(with: URL(string: cell.imageURL), for: .normal, completed: nil)
        cell.addSubview(cell.image)
        cell.addSubview(cell.label)
        cell.image.translatesAutoresizingMaskIntoConstraints = false
        cell.label.translatesAutoresizingMaskIntoConstraints = false
        cell.image.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        cell.image.heightAnchor.constraint(equalToConstant: cell.frame.height*0.9).isActive = true
        cell.image.widthAnchor.constraint(equalToConstant: cell.frame.width).isActive = true
        cell.label.topAnchor.constraint(equalTo: cell.image.bottomAnchor).isActive = true
        cell.label.widthAnchor.constraint(equalToConstant: cell.frame.width).isActive = true
        cell.label.heightAnchor.constraint(equalToConstant: cell.frame.height*0.1).isActive = true
        cell.label.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        cell.label.textAlignment = .center
        cell.label.font = UIFont.boldSystemFont(ofSize: CGFloat(font))
        cell.layer.borderColor = UIColor.brown.cgColor
        cell.layer.borderWidth = 1
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
