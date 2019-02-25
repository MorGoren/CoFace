//
//  GuestListControllerView.swift
//  CoFace
//
//  Created by Timur Misharin on 06/02/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit
import Firebase

class GuestListViewController: UIViewController /*, UICollectionViewDelegate, UICollectionViewDataSource*/ {
    
    var userEmail: String!
    @IBAction func AddUserButton(_ sender: Any) {
    }
    @IBOutlet weak var CollectionView: UICollectionView!
    /*func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! addGuessViewController
        destination.userEmail = self.userEmail
    }

}
