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
    var databaseRef : DatabaseReference!
    var storageRef : StorageReference!
    var flag = false
    var guestInfo = [guestData]()
    
    func getID(email: String){
        databaseRef = Database.database().reference()
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
                self.loadData(key: self.branch)
            }
        })
        sleep(1)
    }
    
     //image: UIImage
    func addGuest(guest: [String : Any], image: UIImage, completion : @escaping ((_ check: String?)->())){
        databaseRef = Database.database().reference()
        if let uid = databaseRef.child("Guest/\(branch ?? "defult")").childByAutoId().key{
            var newGuest : [String : Any] = guest
            UploadImage(folder: "GuestImages",uid: uid, image){ url in
                newGuest["photoURL"] = url
                self.databaseRef.child("Guest/\(self.branch ?? "defult")").child(uid).setValue(newGuest)
                self.guestInfo.append(guestData(data: newGuest, cid: uid))
                completion(uid)
            }
        }
        else {
            completion("no")
        }
        //var guests : [String : Any] = guest
        //["first name": guest["first name"]!, "last name" : guest["last name"]! , "eye" : guest["eye"]!]
        /*UploadImage(folder: "GuestImages",uid: uid, image){ url in
            guests["photoURL"] = url
            self.databaseRef.child("Guest/\(self.branch ?? "defult")").child(uid).setValue(guests)
        }*/
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
    
    private func loadData(key : String){
        guard BranchData.shared.branch != nil  else { print("branch is nil"); return }
        databaseRef = Database.database().reference()
        databaseRef.root.child("Guest").child(key).observe(.value, with: { snapshot in
            var newGuest = [guestData]()
            for g in snapshot.children {
                let gu = guestData(snapshot: g as! DataSnapshot)
                newGuest.append(gu)
                print(newGuest)
            }
            self.guestInfo = newGuest
            print("guest list", self.guestInfo)
        })
    }
    
    private func UploadImage(folder: String,uid: String, _ image: UIImage, completion: @escaping ((_ url: String?)->())) {
        storageRef = Storage.storage().reference().root().child(folder).child(branch).child(uid)
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        print("metaData", imageData)
        storageRef.putData(imageData, metadata: nil, completion: { (metaData, error) in
            print("you are in")
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
