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
    
    var flowLayout: CollectionFlowLayout!
    var guests : [guestData]!
    @IBOutlet weak var collection: UICollectionView!
    
    @IBAction func AddUserButton(_ sender: Any) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flowLayout = CollectionFlowLayout()
        collection.collectionViewLayout = flowLayout
        guests = BranchData.shared.guestInfo
        collection?.reloadData()
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

