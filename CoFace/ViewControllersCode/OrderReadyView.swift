//
//  OrderReadyView.swift
//  CoFace
//
//  Created by Timur Misharin on 29/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class OrderReadyView: UIViewController {

    @IBOutlet weak var background: UIImageView!
    var profile: UIImageView!
    var check: UIButton!
    var frame = UIScreen.main.bounds
    @objc func checkAction() {
        check.pulseAnimation()
        BranchData.shared.removeOrder(id: currentOrder)
        orderList.removeValue(forKey: currentOrder)
        let first = Array(orderList.keys).first
        if first != nil{
            currentOrder = first
            profile.sd_setImage(with: URL(string: orderList[currentOrder]!), placeholderImage: UIImage(named: "profile"))
        }
        else{
            check.isHidden = true
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
        check = addButton()
        check.isHidden = true
        profile = addImage()
        profile.isHidden = true
        currentOrder = "nil"
        timerPreper()
        BackgroundSetup()
        self.view.addSubview(check)
        self.view.addSubview(profile)
    }
    
    private func timerPreper(){
        print("you are in ready order timerPreper")
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.timerPerform), userInfo: nil, repeats: true)
    }
    
    @objc func timerPerform(){
        BranchData.shared.nextOrderReady(dictionary: orderList, cid: currentOrder) { (order, orderid) in
            self.orderList[orderid] = order
            self.check.isHidden = false
            self.profile.isHidden = false
            print("my order list", self.orderList)
            if self.currentOrder == "nil"{
                self.currentOrder = orderid
                self.profile.sd_setImage(with: URL(string:   self.orderList[self.currentOrder]!), placeholderImage: UIImage(named: "profile"))
            }
        }
    }
    
    private func addButton() -> UIButton{
        let button = UIButton(frame: CGRect(x: frame.minX+50, y: frame.maxY/3+50, width: frame.width/4, height: frame.width/4))
        button.setImage(UIImage(named: "checkButton"), for: .normal)
        button.addTarget(self, action: #selector(checkAction), for: .touchUpInside)
        button.layer.cornerRadius = button.frame.size.height / 2
        button.backgroundColor = .clear
        return button
    }
    
    private func addImage() -> UIImageView{
        let image = UIImageView(frame: CGRect(x: frame.maxX/2, y: frame.maxY/3, width: frame.maxX/2, height: frame.maxX/2))
        image.layer.cornerRadius = image.frame.height/2
        return image
    }
    
    private func BackgroundSetup(){
        background.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }

}
