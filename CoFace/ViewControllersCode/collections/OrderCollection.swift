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
    
    var arrayImages = [String: itemData]()
    var cellChange = [String]()
    var imageLayout: CollectionFlowLayout!
    var order: String!
    var index: Int!
    var re: removePhoto?
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var checkButton: UIButton!
    @IBAction func checkAction(_ sender: Any) {
        checkButton.pulseAnimation()
        BranchData.shared.addOrder(order: arrayImages, id: order)
        re?.remove(index: index)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkButton.isHidden = true
        imageLayout = CollectionFlowLayout()
        imageLayout.numberOfItem = 2
        collection.collectionViewLayout = imageLayout
        let array = BranchData.shared.myCategories
        for categoer in array {
            arrayImages[categoer.id] = categoer
        }
        collection?.reloadData()
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
    
    private func check(){
        if cellChange.count == arrayImages.count{
            checkButton.isHidden = false
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
        check()
        arrayImages[category] = cell
        collection.reloadData()
    }
}
