//
//  OrderToDoCollection.swift
//  CoFace
//
//  Created by Timur Misharin on 28/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class OrderToDoCollection: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var background: UIImageView!
    var check: UIButton!
    var frame = UIScreen.main.bounds
    var once = 0
    @objc func checkAction() {
        check.pulseAnimation()
        BranchData.shared.moveToReady(id: currentOrder)
        keys.removeFirst()
        if keys.first != nil{
            currentOrder = keys.first
            items = orderList[currentOrder]!
            collection?.reloadData()
        }
        else{
            items.removeAll()
            check.isHidden = true
            check.isHidden = true
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
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        background.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        collection.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collection.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        check = addButton()
        check.isHidden = true
        flowLayout = CollectionFlowLayout()
        flowLayout.numberOfItem = 2
        collection.collectionViewLayout = flowLayout
        collection.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
        currentOrder = "nil"
        timerPreper()
        keys = Array(orderList.keys)
        self.view.addSubview(check)
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
                self.check.isHidden = false
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
        if once == 0{
            once = 1
            cell.image.translatesAutoresizingMaskIntoConstraints = false
            cell.image.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
            cell.image.widthAnchor.constraint(equalTo: cell.widthAnchor).isActive = true
            cell.image.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            print("my item", count, items)
        }
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
