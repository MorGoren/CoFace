//
//  gustData.swift
//  CoFace
//
//  Created by Timur Misharin on 04/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct guestData {
    
    var cid: String?
    var eye: Int!
    var first: String!
    var last: String!
    var image: String!
    var guestRef : DatabaseReference!
 
    init(cid: String, eye: Int, first: String, last: String, image: String){
        self.cid = cid
        self.eye = eye
        self.first = first
        self.last = last
        self.guestRef = nil
        self.image = image
    }
    
    init(snapshot: DataSnapshot){
        guestRef = snapshot.ref
       //print("SnapShot", snapshot.key)
        //print("SnapShot", snapshot)
        self.cid = snapshot.key
        let snapshotValue = snapshot.value as? [String: Any]
        //print("SnapShotValue", snapshotValue)
        self.eye = snapshotValue?["eye"] as? Int
        self.first = snapshotValue?["last name"] as? String
        self.last = snapshotValue?["first name"] as? String
        self.image = snapshotValue?["photoURL"] as? String
    }
}
