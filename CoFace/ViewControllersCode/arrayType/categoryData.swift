//
//  categoryData.swift
//  CoFace
//
//  Created by Timur Misharin on 14/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct categoryData{
    
    var cid: String!
    var name: String!
    var image: String!

    init(data: [String: Any], id: String){
        self.cid = id
        self.name = data["name"] as? String
        self.image = data["photoURL"] as? String
    }
    
    init(snapshot: DataSnapshot){
        self.cid = snapshot.key
        let snapshotValue = snapshot.value as? [String: Any]
        self.name = snapshotValue?["name"] as? String
        self.image = snapshotValue?["photoURL"] as? String
    }
}
