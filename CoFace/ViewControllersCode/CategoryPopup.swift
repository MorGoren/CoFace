//
//  CategoryPopup.swift
//  CoFace
//
//  Created by Timur Misharin on 13/03/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

import UIKit

protocol category{
    
}
class CategoryPopup: UIViewController {
    
    var cat = BranchData.shared.categoryList
    var bool = true
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var dropTable: UITableView!
    @IBOutlet weak var dropButton: UIButton!
    @IBOutlet weak var add: UIButton!
    @IBAction func addAction(_ sender: Any) {
        bluredEffect()
        if checkWhatEmpty() {
            BranchData.shared.addCategory(category: (dropButton.titleLabel?.text)!, image: (categoryImage.image)!){ check in                sleep(1)
                self.removeSubview()
                if check != "no"{
                    self.view.removeFromSuperview()
                }
                else{
                    self.warningLabel.text = "failed"
                    self.warningLabel.textColor = UIColor.red
                    sleep(2)
                    self.view.removeFromSuperview()
                }
            }
        }
    }
    
    @IBAction func dropAction(_ sender: Any) {
        animate(bool: bool)
        bool = !bool
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropTable.isHidden = true
        warningLabel.isHidden = true
        Setup()
    }
    
    private func Setup(){
        add.frame.size = CGSize(width: 50, height: 50)
        dropButton.layer.borderColor = UIColor.black.cgColor
        dropButton.layer.borderWidth = 3
        dropButton.layer.cornerRadius = dropButton.bounds.height/4
        categoryImage.layer.borderWidth = 3
        categoryImage.layer.borderColor = UIColor.black.cgColor
        dropTable.layer.borderColor = UIColor.black.cgColor
        dropTable.layer.borderWidth = 3
    }
    
    private func bluredEffect(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.tag = 5
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    private func removeSubview(){
        print("Start remove sibview")
        if let viewWithTag = self.view.viewWithTag(5) {
            viewWithTag.removeFromSuperview()
        }else{
            print("No!")
        }
    }
    
    private func checkWhatEmpty()-> Bool{
        if dropButton.titleLabel?.text != "קטגוריה" {
            return true
        }
        return false
    }
    
    private func animate(bool: Bool){
        UITableView.animate(withDuration: 1){
            self.dropTable.isHidden = !bool
        }
    }
    
    private func setImage(){
        var image = UIImage(named: "image")
        switch (dropButton.titleLabel?.text){
            case cat[3]: image = UIImage(named: "fruit")!
            case cat[2]: image = UIImage(named: "snacks")!
            case cat[1]: image = UIImage(named: "cup")!
            case cat[0]: image = UIImage(named: "food")!
        default:
            break
        }
        categoryImage.image = image
    }
}

extension CategoryPopup: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = cat[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dropButton.setTitle("\(cat[indexPath.row])", for: .normal)
        animate(bool: bool)
        bool = !bool
        setImage()
    }
}
