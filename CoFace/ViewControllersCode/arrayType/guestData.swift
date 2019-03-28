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
    
    var cid: String!
    var eye: Int!
    var first: String!
    var last: String!
    var image: String!
 
    init(cid: String, eye: Int, first: String, last: String, image: String){
        self.cid = cid
        self.eye = eye
        self.first = first
        self.last = last
        self.image = image
        
    }
    
    init(data : [String: Any], cid: String){
        self.cid = cid
        self.eye = data["eye"] as? Int
        self.first = data["first name"] as? String
        self.last = data["last name"] as? String
        self.image = data["photoURL"] as? String
    }
    
    init(snapshot: DataSnapshot){
        self.cid = snapshot.key
        let snapshotValue = snapshot.value as? [String: Any]
        self.eye = snapshotValue?["eye"] as? Int
        self.first = snapshotValue?["last name"] as? String
        self.last = snapshotValue?["first name"] as? String
        self.image = snapshotValue?["photoURL"] as? String
    }
}
