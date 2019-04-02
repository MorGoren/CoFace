//
//  StartView.swift
//  CoFace
//
//  Created by Timur Misharin on 31/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class StartView: UIViewController {

    var take: UIButton!
    var cook: UIButton!
    var ready: UIButton!
    var taLabel: UILabel!
    var coLabel: UILabel!
    var reLabel: UILabel!

    @IBOutlet weak var background: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = UIScreen.main.bounds
        let size = UIScreen.main.bounds.height/6
        let x = frame.midX - size/2
        var y = size/2
        take = addButton(name: "write", place: CGRect(x: x, y: CGFloat(y), width: CGFloat(size), height: CGFloat(size)))
        let ly = size*1.1
        y = 2.2*size
        cook = addButton(name: "cook", place: CGRect(x: x, y: y, width: size, height: size))
        y = 3.3*size
        ready = addButton(name: "check", place: CGRect(x: x, y: y+0.5*ly, width: size, height: size))
        
        take.addTarget(self, action: #selector(takeAction), for: .touchUpInside)
        cook.addTarget(self, action: #selector(cookAction), for: .touchUpInside)
        ready.addTarget(self, action: #selector(readyAction), for: .touchUpInside)
        self.view.addSubview(take)
        self.view.addSubview(cook)
        self.view.addSubview(ready)
        BackgroundSetup()
    }
    
    @objc func takeAction(_ sender: UIButton) {
        sender.pulseAnimation()
        performSegue(withIdentifier: "take", sender: self)
    }
    
    @objc func cookAction(_ sender: UIButton) {
        sender.pulseAnimation()
        performSegue(withIdentifier: "cook", sender: self)
    }
    
    @objc func readyAction(_ sender: UIButton) {
        sender.pulseAnimation()
        performSegue(withIdentifier: "ready", sender: self)
    }

    private func BackgroundSetup(){
        background.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    private func addButton(name: String, place: CGRect) -> UIButton{
        let button = UIButton(frame: place)
        button.setImage(UIImage(named: name), for: .normal)
        button.layer.cornerRadius = button.frame.size.height / 2
        button.backgroundColor = .clear
        return button
    }
}
