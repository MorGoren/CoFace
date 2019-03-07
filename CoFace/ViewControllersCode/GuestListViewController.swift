//
//  GuestListControllerView.swift
//  CoFace
//
//  Created by Timur Misharin on 06/02/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SDWebImage

class GuestListViewController: UIViewController, UICollectionViewDataSource{
    
    var flowLayout: CollectionFlowLayout!
    var guest = [guestData]()
    var image = [UIImage]()
    var databaseRef : DatabaseReference!
    @IBOutlet weak var collection: UICollectionView!
    
    @IBAction func AddUserButton(_ sender: Any) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseRef = Database.database().reference().child("Guest")
        flowLayout = CollectionFlowLayout()
        collection.collectionViewLayout = flowLayout
        loadData()
    }
    
    /* override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) 
        databaseRef = Database.database().reference().child("Guest")
        flowLayout = CollectionFlowLayout()
        collection.collectionViewLayout = flowLayout
        loadData()
    }*/
    
    private func loadData(){
        guard BranchData.shared.branch != nil  else { print("branch is nil"); return }
        databaseRef.child(BranchData.shared.branch).observe(.value, with: { snapshot in
            var newGuest = [guestData]()
            for g in snapshot.children {
                let gu = guestData(snapshot: g as! DataSnapshot)
                newGuest.append(gu)
                print("guuu", gu)
            }
            self.guest = newGuest
            self.collection.reloadData()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guest.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! UICell
        cell.layer.borderColor = UIColor.brown.cgColor
        cell.layer.borderWidth = 1
        let index = indexPath.row
        cell.imageURL = URL(string: guest[index].image)
        cell.image.sd_setImage(with: cell.imageURL, placeholderImage: UIImage(named: "profile"))
        cell.firstNameLabel.text = guest[index].first
        cell.lastNameLabel.text = guest[index].last
        cell.cid = guest[index].cid
        cell.eyeImage.frame.size = CGSize(width: 30, height: 30)
        switch (guest[index].eye){
            case 0: cell.eyeImage.image = UIImage(named: "eye")
            case 1: cell.eyeImage.image = UIImage(named: "touch")
        default:
            break
            }
        cell.delegate = self
        return cell
            }
}

extension GuestListViewController : cellDelegate{
    func delete(cell: UICell) {
        if let index = collection?.indexPath(for: cell){
            BranchData.shared.removeGuest(cid: cell.cid, url: cell.imageURL)
            collection?.deleteItems(at: [index])
        }
    }
    
}

