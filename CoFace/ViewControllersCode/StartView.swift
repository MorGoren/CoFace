//
//  StartView.swift
//  CoFace
//
//  Created by Timur Misharin on 31/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

class StartView: UIViewController {

    var take = UIButton()
    var cook = UIButton()
    var ready = UIButton()
    var taLabel = UILabel()
    var coLabel = UILabel()
    var reLabel = UILabel()
    var font: Int!
    @IBOutlet weak var background: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = UIScreen.main.bounds
        let size = frame.height/6
        setFont()
        self.view.addSubview(take)
        self.view.addSubview(taLabel)
        self.view.addSubview(cook)
        self.view.addSubview(coLabel)
        self.view.addSubview(reLabel)
        self.view.addSubview(ready)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        background.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        take.setImage(UIImage(named: "write"), for: .normal)
        take.translatesAutoresizingMaskIntoConstraints = false
        take.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        take.widthAnchor.constraint(equalToConstant: size).isActive = true
        take.heightAnchor.constraint(equalToConstant: size).isActive = true
        take.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        taLabel.text = "מלצר"
        taLabel.textAlignment = .center
        taLabel.textColor = .black
        taLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(font))
        taLabel.textColor = UIColor.black
        taLabel.textAlignment = .center
        taLabel.translatesAutoresizingMaskIntoConstraints = false
        taLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        taLabel.topAnchor.constraint(equalTo: take.bottomAnchor).isActive = true
        taLabel.widthAnchor.constraint(equalToConstant: 1.5*size).isActive = true
        taLabel.heightAnchor.constraint(equalToConstant: 0.2*size).isActive = true
        taLabel.layer.cornerRadius = 20
        cook.setImage(UIImage(named: "cook"), for: .normal)
        cook.translatesAutoresizingMaskIntoConstraints = false
        cook.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cook.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        cook.widthAnchor.constraint(equalToConstant: size).isActive = true
        cook.heightAnchor.constraint(equalToConstant: size).isActive = true
        coLabel.text = "מטבח"
        coLabel.textAlignment = .center
        coLabel.textColor = .black
        coLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(font))
        coLabel.textColor = UIColor.black
        coLabel.textAlignment = .center
        coLabel.translatesAutoresizingMaskIntoConstraints = false
        coLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        coLabel.topAnchor.constraint(equalTo: cook.bottomAnchor).isActive = true
        coLabel.widthAnchor.constraint(equalToConstant: 1.5*size).isActive = true
        coLabel.heightAnchor.constraint(equalToConstant: 0.2*size).isActive = true
        coLabel.layer.cornerRadius = 20
        reLabel.text = "הזמנות מוכנות"
        reLabel.textAlignment = .center
        reLabel.textColor = .black
        reLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(font))
        reLabel.textColor = UIColor.black
        reLabel.textAlignment = .center
        reLabel.translatesAutoresizingMaskIntoConstraints = false
        reLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        reLabel.widthAnchor.constraint(equalToConstant: 1.5*size).isActive = true
        reLabel.heightAnchor.constraint(equalToConstant: 0.2*size).isActive = true
        reLabel.layer.cornerRadius = 20
        ready.setImage(UIImage(named: "check"), for: .normal)
        ready.translatesAutoresizingMaskIntoConstraints = false
        ready.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ready.bottomAnchor.constraint(equalTo: reLabel.topAnchor).isActive = true
        ready.widthAnchor.constraint(equalToConstant: size).isActive = true
        ready.heightAnchor.constraint(equalToConstant: size).isActive = true
        take.addTarget(self, action: #selector(takeAction), for: .touchUpInside)
        cook.addTarget(self, action: #selector(cookAction), for: .touchUpInside)
        ready.addTarget(self, action: #selector(readyAction), for: .touchUpInside)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.isHidden = false
        BackgroundSetup()
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = .black
        self.navigationItem.title = "תפריט אפשרויות"
        let backButton = UIBarButtonItem()
        backButton.title = "אחורה"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

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
    private func setFont(){
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            font = 15
        case .pad:
            font = 25
        case .unspecified:
            font = 25
        case .tv:
            font = 25
        case .carPlay:
            font = 15
        @unknown default:
            font = 25
        }
    }
}
