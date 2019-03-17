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
    var category = [categoryData]()
    var categoryList: Array = ["אוכל", "שתיה", "חטיף", "פרי"]
    
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
                self.loadData(folder: "Guest")
                self.loadData(folder: "Category")
            }
        })
        sleep(1)
    }
    
     //image: UIImage
    func addGuest(guest: [String : Any], image: UIImage, completion : @escaping ((_ check: String?)->())){
        databaseRef = Database.database().reference()
        if let uid = databaseRef.child("Guest/\(branch ?? "defult")").childByAutoId().key{
            var newGuest : [String : Any] = guest
            UploadImage(folder: "Guest",id: uid, image){ url in
                newGuest["photoURL"] = url
                self.databaseRef.child("Guest/\(self.branch ?? "defult")").child(uid).setValue(newGuest)
                self.guestInfo.append(guestData(data: newGuest, cid: uid))
                completion(uid)
            }
        }
        else {
            completion("no")
        }
    }
    
    func addCategory(category: String, image: UIImage, completion: @escaping ((_ check: String?)->())){
        databaseRef = Database.database().reference()
        if let cid = databaseRef.child("Category/\(branch ?? "defult")").childByAutoId().key{
            let newCategory = ["name": category]
            self.databaseRef.child("Category/\(self.branch ?? "defult")").child(cid).setValue(newCategory)
            self.category.append(categoryData(data: newCategory, id: cid))
            completion(cid)
        }
        else{
            completion("no")
        }
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
    
    func removeGuest(cid: String, url: String){
        removeFromStorage(url: url)
        removeFromDatabase(path: "Guest/\(branch ?? "defult")/\(cid)")
    }
    
    func removeCategory(cid: String){
        removeFromDatabase(path: "Category/\(branch ?? "defult")/\(cid)")
    }
    
    private func loadData(folder: String){
        guard BranchData.shared.branch != nil  else { print("branch is nil"); return }
        databaseRef = Database.database().reference()
        databaseRef.root.child(folder).child(self.branch).observe(.value, with: { snapshot in
            switch folder{
                case "Guest":
                    var newData = [guestData]()
                    for nd in snapshot.children {
                        let data = guestData(snapshot: nd as! DataSnapshot)
                        newData.append(data)
                        print(newData)
                    }
                    self.guestInfo = newData
                    print("guest list", self.guestInfo)
                case "Category":
                    var newData = [categoryData]()
                    for nd in snapshot.children {
                        let data = categoryData(snapshot: nd as! DataSnapshot)
                        newData.append(data)
                        print("Category", newData)
                    }
                self.category = newData
                print("category list", self.category)
                //case "Item":
            default:
                break
            }
        })
    }
    
   /* private func addToDatabase(path: String, item: [String: Any], itemImage: UIImage, to: String, completion : @escaping ((_ check: String?)->())){
        databaseRef = Database.database().reference()
        if let uid = databaseRef.child(path).childByAutoId().key{
            addToStorage(path: path, completion: <#T##((String?) -> ())##((String?) -> ())##(String?) -> ()#>)
        }
    }
    
    private func addToStorage(path: String, completion : @escaping ((_ check: String?)->())){
        
    }*/
    
    private func removeFromDatabase(path: String){
        databaseRef = Database.database().reference()
        databaseRef.child(path).removeValue()
        print("you are un remove from database")
    }
    
    private func removeFromStorage(url: String){
        let store = Storage.storage().reference(forURL: url)
        store.delete(completion: {error in
            if let error = error{
                print("faild", error)
            }
            else{
                print("success")
            }
        })
    }

    private func UploadImage(folder: String,id: String, _ image: UIImage, completion: @escaping ((_ url: String?)->())) {
        storageRef = Storage.storage().reference().root().child(folder).child(branch).child(id)
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
