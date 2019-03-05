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
    
    let cid: String?
    let eye: String!
    let first: String!
    let last: String!
    let image: String!
    let guestRef : DatabaseReference!
    
    init(cid: String, eye: String, first: String, last: String, image: String){
        self.cid = cid
        self.eye = eye
        self.first = first
        self.last = last
        self.image = image
        self.guestRef = nil
    }
    
    init(snapshot: DataSnapshot){
        guestRef = snapshot.ref
        
        let snapshotValue = snapshot.value as! [String: String]
        
        cid = snapshot.key
        eye = snapshotValue["eye"]
        first = snapshotValue["last name"]
        last = snapshotValue["first name"]
        image = snapshotValue["photoURL"]
    }
}
