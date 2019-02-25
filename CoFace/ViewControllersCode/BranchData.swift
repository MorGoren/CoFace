//
//  BranchData.swift
//  CoFace
//
//  Created by Timur Misharin on 22/02/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

//used like singelton

class BranchData {
    
    static let shared = BranchData()
    var branch: String!
    var databaseRef : DatabaseReference!
    var flag = false
    
    func getID(email: String){
        let group = DispatchGroup()
        group.enter()
        databaseRef = Database.database().reference()
        databaseRef.root.child("Branches").observe(.value, with: { (snapshot) in
            if ((snapshot.children.allObjects as? [DataSnapshot]) != nil) {
                print(snapshot)
                let child = snapshot.value as! [String: [String : String]]
                print(child)
                print("unwrap email", email)
                for (key, data) in child{
                    for (k, d) in data{
                        if k == "Email" && d == email {
                            self.branch = key
                        }
                    }
                }
                /*
                print("child", child)*/
            }
        })
    }
     //image: UIImage
    func addGuest(guest: [String : Any], image: UIImage){
        let uid = databaseRef.child("Guest/\(branch ?? "defult")").childByAutoId().key!
        print("uiddddd", uid)
        UploadGuestImage(folder: "GuestImages",uid: uid, image)
        databaseRef.child("Guest/\(branch ?? "defult")").child(uid).setValue(guest)
        
        //uid.setValue(guest)
    }
    
    func addCategory(category: String){
        
    }
    
    func addItem(item: Any){
        
    }
    
    private func unwrap<T>(_ any: T) -> String
    {
        let mirror = Mirror(reflecting: any)
        guard mirror.displayStyle == .optional, let first = mirror.children.first else {
            return "non"
        }
        return first.value as! String
    }
    
    func unwrap2(){
        if !flag{
            branch = unwrap(branch)
        }
    }
    
    func UploadGuestImage(folder: String,uid: String, _ image: UIImage) {
        let storageRef = Storage.storage().reference().child(folder).child(branch).child(uid)
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        storageRef.putData(imageData, metadata: nil, completion: { (metaData, error) in
            if error != nil {
                print(error)
                return
            }
            print(metaData)
            
        })
    }
}
