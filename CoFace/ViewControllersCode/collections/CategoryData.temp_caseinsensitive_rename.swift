//
//  categoryData.swift
//  CoFace
//
//  Created by Timur Misharin on 13/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct CategoryData{
    
    var cid: String?
    var name: String!
    var image: String!
    
    init(data: [String: String], id: String){
        self.cid = id
        self.name = data["name"]
        self.image = data["photoURL"]
    }
    
    init(snapshot: DataSnapshot){
        self.cid = snapshot.key
        let snapshotValue = snapshot.value as? [String: Any]
        //print("SnapShotValue", snapshotValue)
        self.name = snapshotValue?["name"] as? String
        self.image = snapshotValue?["photoURL"] as? String
    }
}
