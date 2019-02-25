//
//  ScaleSegue.swift
//  CoFace
//
//  Created by Timur Misharin on 13/02/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class ScaleSegue: UIStoryboardSegue {
    
    var data: String!
    
    override func perform() {
        Scale()
    }
    
    private func Scale(){
        let toViewController =  self.destination
        let fromViewController = self.source
        let containerView = fromViewController.view.superview
        let originalView = fromViewController.view.center
        toViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        toViewController.view.center = originalView
        containerView?.addSubview(toViewController.view)
        UIView.animate(withDuration: 0.5, animations: {toViewController.view.transform = CGAffineTransform.identity}, completion : { success in fromViewController.present(toViewController, animated: false, completion: nil)
            
        })
    }
}
