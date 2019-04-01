//
//  OrderToDoCollection.swift
//  CoFace
//
//  Created by Timur Misharin on 28/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class OrderToDoCollection: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var checkButton: UIButton!
    @IBAction func checkAction(_ sender: Any) {
        checkButton.pulseAnimation()
        BranchData.shared.moveToReady(id: currentOrder)
        keys.removeFirst()
        if keys.first != nil{
            currentOrder = keys.first
            items = orderList[currentOrder]!
            collection?.reloadData()
        }
        else{
            items.removeAll()
            collection.isHidden = true
            checkButton.isHidden = true
             let actionSheet = UIAlertController(title: "מעולה!", message: "הפעילות נגמרה, אין עוד הזמנות", preferredStyle: .actionSheet)
            if let popoverController = actionSheet.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
            self.present(actionSheet, animated: true, completion: nil)
            let when = DispatchTime.now() + 3
            DispatchQueue.main.asyncAfter(deadline: when){
                actionSheet.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
    @IBOutlet weak var collection: UICollectionView!
    var timer =  Timer()
    var orderList = [String: [itemData]]()
    var items = [itemData]()
    var flowLayout : CollectionFlowLayout!
    var currentOrder: String!
    var keys = [String]()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkButton.isHidden = true
        checkButton.frame.size = CGSize(width: 100, height: 100)
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
        BranchData.shared.nextOrder(dictionary: orderList, cid: currentOrder){ (order, orderid) in
            self.orderList[orderid] = order
            print("my order list", self.orderList)
            if self.currentOrder == "nil"{
                self.currentOrder = orderid
                self.items = order
                self.collection?.reloadData()
                self.checkButton.isHidden = false
            }
            self.keys.append(orderid)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! OrderToDoUICell
        count += 1
        print("my item", count, items)
        if cell.image != nil{
            let url = URL(string: items[indexPath.row].image)
            let image = UIImage(named: "image")
            cell.frame.size.width = UIScreen.main.bounds.width / 2
            cell.image.sd_setImage(with: url, placeholderImage: image)
            cell.layer.borderColor = UIColor.brown.cgColor
            cell.layer.borderWidth = 1
        }
        return cell
    }
}
