//
//  GuestListControllerView.swift
//  CoFace
//
//  Created by Timur Misharin on 06/02/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit
import SDWebImage

class GuestListViewController: UIViewController, UICollectionViewDataSource{
    
    @IBOutlet weak var background: UIImageView!
    var flowLayout: CollectionFlowLayout!
    var guests : [guestData]!
    @IBOutlet weak var collection: UICollectionView!
    
    @objc func AddUserAction() {
        performSegue(withIdentifier: "addUser", sender: self)
    }
    var frame = UIScreen.main.bounds
    var addGuest: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        flowLayout = CollectionFlowLayout()
        collection.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
        flowLayout.numberOfItem = 3
        collection.collectionViewLayout = flowLayout
        guests = BranchData.shared.guestInfo
        collection?.reloadData()
        addGuest = addButton()
        backgroundSetup()
        self.view.addSubview(addGuest)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guests = BranchData.shared.guestInfo
        print("viewWillApear guests", guests)
        collection?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GuestUICell
        cell.layer.borderColor = UIColor.brown.cgColor
        cell.layer.borderWidth = 1
        let index = indexPath.row
        print("Cell index", index, "Cell", cell)
        cell.printCell()
        cell.imageURL = URL(string: guests[index].image)
        if cell.image != nil {
            cell.image.sd_setImage(with: cell.imageURL, placeholderImage: UIImage(named: "profile")!)
            cell.firstNameLabel.text = guests[index].first
            cell.lastNameLabel.text = guests[index].last
            cell.cid = guests[index].cid
            cell.eyeImage.frame.size = CGSize(width: 25, height: 30)
            switch (guests[index].eye){
                case 0: cell.eyeImage.image = UIImage(named: "eye")
                case 1: cell.eyeImage.image = UIImage(named: "touch")
            default:
                break
                }
            cell.delegateDelete = self
        }
        return cell
    }
    
    private func addButton() -> UIButton{
        let y = frame.height/20
        let button = UIButton(frame: CGRect(x: frame.minX, y: frame.maxY-y, width: frame.width, height: y))
        button.setTitle("הוסף משתמש", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25.0)
        button.addTarget(self, action: #selector(AddUserAction), for: .touchUpInside)
        button.layer.cornerRadius = button.frame.size.height / 2
        button.backgroundColor = UIColor.init(white: CGFloat(1.0), alpha: CGFloat(0.56))
        return button
    }
    
    private func backgroundSetup(){
          background.frame = CGRect(x: frame.minX, y: frame.minY+150, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}

extension GuestListViewController : cellDeleteDelegate{
    func delete(cell: GuestUICell) {
        if let index = collection?.indexPath(for: cell){
            BranchData.shared.removeGuest(cid: cell.cid, url: cell.imageURL.absoluteString)
            print("Index", index)
            guests.remove(at: index.row)
            //collection?.deleteItems(at: [index])
            collection?.reloadData()
        }
    }
}

