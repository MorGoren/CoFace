//
//  PictureCollection.swift
//  CoFace
//
//  Created by User on 25/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class PictureCollection: UIViewController, UICollectionViewDataSource,removePhoto {
    
    
    var arrayImages = [guestData]()
    var imageLayout: CollectionFlowLayout!
    @IBOutlet weak var collection: UICollectionView!
    var frame = UIScreen.main.bounds
    @IBOutlet weak var background: UIImageView!
    
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
        imageLayout = CollectionFlowLayout()
        imageLayout.numberOfItem = 2
        collection.collectionViewLayout = imageLayout
        arrayImages = BranchData.shared.guestInfo
        collection?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PictureCell
        cell.image.translatesAutoresizingMaskIntoConstraints = false
        cell.image.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        cell.image.widthAnchor.constraint(equalTo: cell.widthAnchor).isActive = true
        cell.image.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
        let url = URL(string: arrayImages[indexPath.row].image)
        cell.layer.borderColor = UIColor.brown.cgColor
        cell.layer.borderWidth = 1
        cell.image.sd_setImage(with: url, placeholderImage:UIImage(named: "profile"))
        cell.id = arrayImages[indexPath.row].cid
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pictureSegue" {
            let destinationVC = segue.destination as! OrderCollection
            let cell = sender as! PictureCell
            destinationVC.order = cell.id
            destinationVC.index = findIndex(id: cell.id)
            destinationVC.re = self
        }
    }
    
    func remove(index: Int) {
        if arrayImages.isEmpty {
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
    else{
        arrayImages.remove(at: index)
        collection?.reloadData()
        }
    }
    
    private func findIndex(id: String)-> Int{
        var i = 0
        while arrayImages[i].cid != id{
            i+=1
        }
        return i
    }
}
