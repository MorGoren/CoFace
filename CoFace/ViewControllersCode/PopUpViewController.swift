//
//  PopUoViewController.swift
//  CoFace
//
//  Created by Timur Misharin on 08/02/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

protocol SourceProtocol{
    func didChose(source: String)
}

class PopUpViewController: UIViewController {

    var ProtocolMess: SourceProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewSetup()
        ShowAnime()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var PopView: UIImageView!
    
    @IBAction func CameraButton(_ sender: Any) {
        CloseAnime(source: "camera")
    }
    
    @IBAction func GaleryButton(_ sender: Any) {
        CloseAnime(source: "galery")
    }
    
    private func ViewSetup(){
        PopView.layer.borderColor = UIColor.black.cgColor
        PopView.layer.cornerRadius = 50
    }
    
    private func ShowAnime(){
        view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        view.alpha = 0.0
        UIView.animate(withDuration: 0.2, animations: {self.view.alpha = 1.0; self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)});
    }
    
    private func CloseAnime(source : String){
        UIView.animate(withDuration: 0.2, animations: {self.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.view.alpha = 0.0;}, completion: nil)
        self.ProtocolMess?.didChose(source: source)
        self.view.removeFromSuperview()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
