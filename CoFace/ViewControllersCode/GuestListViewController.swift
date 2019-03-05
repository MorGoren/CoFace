//
//  GuestListControllerView.swift
//  CoFace
//
//  Created by Timur Misharin on 06/02/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit
import Firebase

class GuestListViewController: UIViewController, UICollectionViewDataSource /*, UICollectionViewDelegate, UICollectionViewDataSource*/ {
    var flowLayout: CollectionFlowLayout!
    var guest = [guestData]()
    @IBAction func AddUserButton(_ sender: Any) {
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flowLayout = CollectionFlowLayout()
        collectionView.collectionViewLayout = flowLayout
        //loadData(){}
    }
    
    private func loadData(){
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guest.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! UICell
        /*
        let index = indexPath.row
        cell.image.image = UIImage(contentsOfFile: imageList[index])
        cell.firstNameLabel.text = firstList[index] as? String
        cell.lastNameLabel.text = lastList[index] as? String
        cell.cid = keyList[index]
        switch (eyeList[index]){
            case 0: cell.eyeImage.image = UIImage(named: "eye")
            case 1: cell.eyeImage.image = UIImage(named: "touch")
        default:
            break
        }*/
        return cell
    }
    
}
