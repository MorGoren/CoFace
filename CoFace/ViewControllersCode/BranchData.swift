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
    var categoryList = [categoryData]()
    var guestInfo = [guestData]()
    var myCategories = [categoryData]()
    var myItems = [String: [itemData]]()
    
    func getID(email: String, completion: @escaping ((_ check: Bool?)->())){
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
                self.loadGuest()
                self.loadCategories()
                self.loadMyCategories(completion: { check in
                    if check == true{
                        self.loadMyItems()
                    }
                })
            }
            completion(true)
        })
        completion(false)
    }
    
     //image: UIImage
    func addGuest(guest: [String : Any], image: UIImage, completion : @escaping ((_ check: String?)->())){
        databaseRef = Database.database().reference()
        let path = "Guest/\(branch ?? "defult")"
        if let uid = databaseRef.child(path).childByAutoId().key{
            var newGuest : [String : Any] = guest
            UploadImage(path: path ,id: uid, image){ url in
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
    
    func addCategory(category: [String: Any], completion: @escaping ((_ check: String?)->())){
        databaseRef = Database.database().reference()
        if let cid = databaseRef.child("Category/\(branch ?? "defult")").childByAutoId().key{
            self.databaseRef.child("Category/\(self.branch ?? "defult")").child(cid).setValue(category)
            self.myCategories.append(categoryData(data: category, id: cid))
            completion(cid)
        }
        else{
            completion("no")
        }
    }
    
    func addCategoryList(category: [String: Any], image: UIImage, completion: @escaping ((_ check: String?)->())){
        databaseRef = Database.database().reference()
        if let id = databaseRef.child("CategoryList").childByAutoId().key{
            var new : [String : Any] = category
            let path = "CategoryList"
            UploadImage(path: path,id: id, image){ url in
                new["photoURL"] = url
                self.databaseRef.child("CategoryList").child(id).setValue(new)
                self.categoryList.append(categoryData(data: new, id: id))
                completion(id)
            }
        }
        else {
            completion("no")
        }
    }
    
    func addItem(category: String, item: [String: Any], image: UIImage, completion: @escaping ((_ check: String?)->())){
        databaseRef = Database.database().reference()
        if let id = databaseRef.child("Items/\(category)").childByAutoId().key{
            var new : [String : Any] = item
            let path = "Items/\(category)"
            UploadImage(path: path,id: id, image){ url in
                new["photoURL"] = url
                self.databaseRef.child("Items/\(category)").child(id).setValue(new)
                self.myItems[category]?.append((itemData(data: new, id: id)))
                completion(id)
            }
        }
        else {
            completion("no")
        }
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
    
    func removeItem(path: String, url: String){
        removeFromDatabase(path: path)
        removeFromStorage(url: url)
    }
    
    private func loadGuest(){
        guard BranchData.shared.branch != nil  else { print("branch is nil"); return }
        databaseRef.root.child("Guest").child(self.branch).observe(.value, with: { snapshot in
                var newData = [guestData]()
                for nd in snapshot.children {
                    let data = guestData(snapshot: nd as! DataSnapshot)
                    newData.append(data)
                    //print(newData)
                }
                self.guestInfo = newData
        })
    }
    
    private func loadMyCategories(completion: @escaping ((_ check: Bool?)->())){
        guard BranchData.shared.branch != nil  else { print("branch is nil"); return }
        databaseRef = Database.database().reference()
        databaseRef.root.child("Category").child(self.branch).observe(.value, with: { snapshot in
            var newData = [categoryData]()
            for nd in snapshot.children {
                let data = categoryData(snapshot: nd as! DataSnapshot)
                newData.append(data)
                //print("Category", newData)
            }
            self.myCategories = newData
            completion(true)
        })
    }
    
    private func loadCategories(){
        databaseRef = Database.database().reference()
        databaseRef.root.child("CategoryList").observe(.value, with: { snapshot in
            var newData = [categoryData]()
            for nd in snapshot.children {
                let data = categoryData(snapshot: nd as! DataSnapshot)
                newData.append(data)
                //print("Category", newData)
            }
            self.categoryList = newData
            //print("category list", self.categoryList)
        })
    }
    
    func loadMyItems(){
        databaseRef = Database.database().reference().root.child("Items")
        print("my categories", self.myCategories)
        for category in self.myCategories{
            print("im in!!!")
            databaseRef.child(category.cid).observe(.value, with: { snapshot in
                var newData = [itemData]()
                for nd in snapshot.children{
                    let data = itemData(snapshot: nd as! DataSnapshot)
                    newData.append(data)
                    print("item new data", newData)
                }
                self.myItems[category.cid] = newData
            })
            print("myItem array until now", self.myItems)
        }
    }
    
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

    private func UploadImage(path: String,id: String, _ image: UIImage, completion: @escaping ((_ url: String?)->())) {
        storageRef = Storage.storage().reference().root().child(path).child(id)
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
