//
//  itemData.swift
//  CoFace
//
//  Created by Timur Misharin on 17/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct itemData{
    
    var name: String!
    var id: String!
    var image: String!
    
    init(data: [String: Any], id: String) {
        self.id = id
        self.image = data["photoURL"] as? String
        self.name = data["name"] as? String
    }
    
    init (snapshot: DataSnapshot){
        self.id = snapshot.key
        let snapshotValue = snapshot.value as? [String: Any]
        self.name = snapshotValue?["name"] as? String
        self.image = snapshotValue?["photoURL"] as? String
    }
}
