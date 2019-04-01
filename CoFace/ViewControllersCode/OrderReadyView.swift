//
//  OrderReadyView.swift
//  CoFace
//
//  Created by Timur Misharin on 29/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class OrderReadyView: UIViewController {

    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var checkButton: UIButton!
    @IBAction func checkAction(_ sender: Any) {
        checkButton.pulseAnimation()
        BranchData.shared.removeOrder(id: currentOrder)
        orderList.removeValue(forKey: currentOrder)
        let first = Array(orderList.keys).first
        if first != nil{
            currentOrder = first
            profile.sd_setImage(with: URL(string: orderList[currentOrder]!), placeholderImage: UIImage(named: "profile"))
        }
        else{
            checkButton.isHidden = true
            profile.isHidden = true
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
    
    var timer = Timer()
    var currentOrder: String!
    var orderList = [String: String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        checkButton.isHidden = true
        profile.isHidden = true
        currentOrder = "nil"
        timerPreper()
        profile.layer.cornerRadius = profile.frame.height / 2
    }
    
    private func timerPreper(){
        print("you are in ready order timerPreper")
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.timerPerform), userInfo: nil, repeats: true)
    }
    
    @objc func timerPerform(){
        BranchData.shared.nextOrderReady(dictionary: orderList, cid: currentOrder) { (order, orderid) in
            self.orderList[orderid] = order
            self.checkButton.isHidden = false
            self.profile.isHidden = false
            print("my order list", self.orderList)
            if self.currentOrder == "nil"{
                self.currentOrder = orderid
                self.profile.sd_setImage(with: URL(string:   self.orderList[self.currentOrder]!), placeholderImage: UIImage(named: "profile"))
            }
        }
    }
}
