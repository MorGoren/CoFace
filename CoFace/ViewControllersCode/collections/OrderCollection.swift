//
//  OrderCollection.swift
//  CoFace
//
//  Created by User on 25/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

protocol removePhoto: class{
    func remove(index: Int)
}

class OrderCollection: UIViewController, UICollectionViewDataSource, returnItem {
    
    @IBOutlet weak var background: UIImageView!
    var arrayImages = [String: itemData]()
    var cellChange = [String]()
    var imageLayout: CollectionFlowLayout!
    var order: String!
    var index: Int!
    var re: removePhoto?
    var frame = UIScreen.main.bounds
    @IBOutlet weak var collection: UICollectionView!
    var check: UIButton!
    @objc func checkAction() {
        check.pulseAnimation()
        BranchData.shared.addOrder(order: arrayImages, id: order)
        re?.remove(index: index)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLayout = CollectionFlowLayout()
        imageLayout.numberOfItem = 2
        collection.collectionViewLayout = imageLayout
        let array = BranchData.shared.myCategories
        for categoer in array {
            arrayImages[categoer.id] = categoer
            print("my category", arrayImages)
        }
        collection.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
        collection?.reloadData()
        check = addButton()
        check.isHidden = true
        self.view.addSubview(check)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OrderCell
        let item = getvalue(place: indexPath.row)
        let url = URL(string: item.image)
        cell.frame.size.width = UIScreen.main.bounds.width / 2
        cell.layer.borderColor = UIColor.brown.cgColor
        cell.layer.borderWidth = 1
        cell.image.sd_setImage(with: url, placeholderImage:UIImage(named: "image")
        )
        cell.id = item.id
        cell.index = indexPath
        return cell
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "orderSegue" {
            let destinationVC = segue.destination as! CheckCollection
            let cell = sender as! OrderCell
            destinationVC.category = getid(place: cell)
            destinationVC.prot = self
        }
    }
    
    private func orderReady(){
        if cellChange.count == arrayImages.count{
            check.isHidden = false
        }
    }
    
    private func getvalue(place: Int) -> itemData{
        return Array(arrayImages.values)[place]
    }
    
    private func getid(place: OrderCell) -> String{
        return Array(arrayImages.keys)[place.index.row]
    }
    
    func item(cell: itemData, category: String) {
        if !cellChange.contains(category){
            cellChange.append(category)
        }
        orderReady()
        arrayImages[category] = cell
        collection.reloadData()
    }
    
    private func BackgroundSetup(){
        background.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    private func addButton() -> UIButton{
        let size = frame.height/10
        let button = UIButton(frame: CGRect(x: frame.maxX/2-size/2, y: frame.maxY/2-size/2, width: size, height: size))
        button.setImage(UIImage(named: "checkButton"), for: .normal)
        button.addTarget(self, action: #selector(checkAction), for: .touchUpInside)
        button.layer.cornerRadius = button.frame.size.height / 2
        button.backgroundColor = .clear
        return button
    }

}
