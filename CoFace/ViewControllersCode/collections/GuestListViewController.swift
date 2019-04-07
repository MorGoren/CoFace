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
    var font: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        setFont()
        addGuest = addButton()
        self.view.addSubview(addGuest)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        background.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        //self.navigationItem.titleView!.bottomAnchor
        collection.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        collection.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        //collection.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        flowLayout = CollectionFlowLayout()
        collection.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
         collection.bottomAnchor.constraint(equalTo: addGuest.topAnchor).isActive = true
        flowLayout.numberOfItem = 2
        collection.collectionViewLayout = flowLayout
        guests = BranchData.shared.guestInfo
        collection?.reloadData()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guests = BranchData.shared.guestInfo
        //print("viewWillApear guests", guests)
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
      if cell.image != nil {
        cell.addSubview(cell.firstNameLabel)
        cell.addSubview(cell.trash)
        cell.addSubview(cell.edit)
        cell.addSubview(cell.lastNameLabel)
        cell.addSubview(cell.eyeImage)
        cell.image.translatesAutoresizingMaskIntoConstraints = false
        cell.firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.image.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        cell.lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.eyeImage.translatesAutoresizingMaskIntoConstraints = false
        cell.image.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        cell.image.widthAnchor.constraint(equalTo: cell.widthAnchor).isActive = true
        cell.image.heightAnchor.constraint(equalToConstant: cell.frame.height*0.8).isActive = true
        cell.trash.translatesAutoresizingMaskIntoConstraints = false
        cell.trash.topAnchor.constraint(equalTo: cell.image.bottomAnchor).isActive = true
        cell.trash.widthAnchor.constraint(equalToConstant: cell.frame.width/8).isActive = true
        cell.trash.heightAnchor.constraint(equalToConstant: cell.frame.width/8).isActive = true
        cell.trash.rightAnchor.constraint(equalTo: cell.image.rightAnchor).isActive = true
        cell.edit.translatesAutoresizingMaskIntoConstraints = false
        cell.edit.topAnchor.constraint(equalTo: cell.image.bottomAnchor).isActive = true
        cell.edit.widthAnchor.constraint(equalToConstant: cell.frame.width/8).isActive = true
        cell.edit.heightAnchor.constraint(equalToConstant: cell.frame.width/8).isActive = true
        cell.edit.leftAnchor.constraint(equalTo: cell.image.leftAnchor).isActive = true
        cell.firstNameLabel.topAnchor.constraint(equalTo: cell.lastNameLabel.bottomAnchor).isActive = true
        cell.firstNameLabel.rightAnchor.constraint(equalTo: cell.trash.leftAnchor).isActive = true
        cell.firstNameLabel.leftAnchor.constraint(equalTo: cell.edit.rightAnchor).isActive = true
        cell.firstNameLabel.heightAnchor.constraint(equalToConstant: cell.frame.height*0.1)
        cell.firstNameLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        cell.firstNameLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(font))
        cell.firstNameLabel.textColor = .black
        cell.lastNameLabel.topAnchor.constraint(equalTo: cell.image.bottomAnchor, constant: 10).isActive = true
        cell.lastNameLabel.heightAnchor.constraint(equalToConstant: cell.frame.height*0.1).isActive = true
        cell.lastNameLabel.widthAnchor.constraint(equalTo: cell.widthAnchor).isActive = true
        cell.lastNameLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(font))
        cell.lastNameLabel.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        cell.eyeImage.translatesAutoresizingMaskIntoConstraints = false
        cell.eyeImage.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        cell.eyeImage.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
        cell.eyeImage.widthAnchor.constraint(equalToConstant: cell.frame.width/8).isActive = true
        cell.eyeImage.heightAnchor.constraint(equalToConstant: cell.frame.width/8).isActive = true
        cell.imageURL = URL(string: guests[index].image)
        cell.image.sd_setImage(with: cell.imageURL, placeholderImage: UIImage(named: "profile")!)
        //cell.firstNameLabel.text = guests[index].first
        cell.lastNameLabel.text = guests[index].last
        cell.lastNameLabel.text?.append(" ")
        cell.lastNameLabel.text?.append(guests[index].first)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit"{
            let destinationCV = segue.destination as! addGuessViewController
            let buSender = sender as! UIButton
            let cell = buSender.superview as! GuestUICell
            let index = collection.indexPath(for: cell)!.row
            destinationCV.guestEdit = guests[index]
            print("edit that user", guests[index])
        }
    }
    
    private func setFont(){
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            font = 15
        case .pad:
            font = 25
        case .unspecified:
            font = 25
        case .tv:
            font = 25
        case .carPlay:
            font = 15
        @unknown default:
            font = 25
        }
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

