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

enum FirebaseError: Error{
    case FailToAdd
    case FailToEdit
    case FailToGet
}

class BranchData {
    
    static let shared = BranchData()
    var branch: String!
    var databaseRef = Database.database().reference()
    var storageRef = Storage.storage().reference()
    var flag = false
    var guestInfo : Any!
    
    func getID(email: String){
        databaseRef.root.child("Branches").observe(.value, with: { (snapshot) in
            if ((snapshot.children.allObjects as? [DataSnapshot]) != nil) {
                //print(snapshot)
                let child = snapshot.value as! [String: [String : String]]
                //print(child)
                //print("unwrap email", email)
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
        sleep(1)
    }
    
     //image: UIImage
    func addGuest(guest: [String : Any], image: UIImage){
        guard let uid = databaseRef.child("Guest/\(branch ?? "defult")").childByAutoId().key else {return}
        var guests : [String : Any] = ["first name": guest["first name"]!, "last name" : guest["last name"]! , "eye" : guest["eye"]!]
        
        UploadImage(folder: "GuestImages",uid: uid, image){ url in
            guests["photoURL"] = url
            self.databaseRef.child("Guest/\(self.branch ?? "defult")").child(uid).setValue(guests)
        }
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
    
    func removeGuest(cid: String, url: URL){
        let store = Storage.storage().reference(withPath: "Guest/\(branch ?? "defult")/\(cid)")
        store.delete(completion: {error in
            if let error = error{
                print("faild", error)
            }
            else{
                print("success")
            }
        })
        databaseRef.child("Guest/\(branch ?? "defult")/\(cid)").removeValue()
    }
    private func UploadImage(folder: String,uid: String, _ image: UIImage, completion: @escaping ((_ url: String?)->())) {
        storageRef = Storage.storage().reference().child(folder).child(branch).child(uid)
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        storageRef.putData(imageData, metadata: nil, completion: { (metaData, error) in
            if error == nil && metaData != nil{
                //succsess to upload to storage
                self.storageRef.downloadURL(completion: { (url, error) in
                    if let url = url {
                        completion(url.absoluteString)
                    }
                    else {
                        completion(nil)
                    }
                })
            }
            else {
                // failed to upload to storage
                completion(nil)
            }
        })
    }
}
