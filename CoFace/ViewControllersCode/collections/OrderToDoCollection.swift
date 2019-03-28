//
//  OrderToDoCollection.swift
//  CoFace
//
//  Created by Timur Misharin on 28/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class OrderToDoCollection: UIViewController, UICollectionViewDataSource{
    
    @IBOutlet weak var checkButton: UIButton!
    @IBAction func checkAction(_ sender: Any) {
        BranchData.shared.moveToReady(id: currentOrder)
        orderList.removeValue(forKey: currentOrder)
        if Array(orderList.keys).first != nil{
            currentOrder = Array(orderList.keys).first
            items = orderList[currentOrder]!
            collection?.reloadData()
        }
        //currentOrder =
    }
    @IBOutlet weak var collection: UICollectionView!
    var timer =  Timer()
    var orderList = [String: [itemData]]()
    var items = [itemData]()
    var flowLayout : CollectionFlowLayout!
    var currentOrder: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkButton.layer.cornerRadius = checkButton.frame.height / 2
        checkButton.layer.borderColor = UIColor.black.cgColor
        checkButton.layer.borderWidth = 2
        flowLayout = CollectionFlowLayout()
        flowLayout.numberOfItem = 2
        collection.collectionViewLayout = flowLayout
        currentOrder = "nil"
        timerPreper()
    }
    
    private func timerPreper(){
        print("you are in timerPreper func")
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.timerPerform), userInfo: nil, repeats: true)
    }
    
    @objc func timerPerform(){
        BranchData.shared.nextOrder(dictionay: orderList, cid: currentOrder){ (order, orderid) in
            self.orderList[orderid] = order
            print("my order list", self.orderList)
            if self.currentOrder == "nil"{
                self.currentOrder = orderid
                self.items = order
                self.collection?.reloadData()
            }
        }
        print("you are in timerPerform func")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! OrderToDoUICell
        cell.image.sd_setImage(with: URL(string: items[indexPath.row].image), placeholderImage:UIImage(named: "image"))
        cell.layer.borderColor = UIColor.brown.cgColor
        cell.layer.borderWidth = 1
            return cell
    }
}
