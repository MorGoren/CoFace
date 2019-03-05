//
//  ViewController.swift
//  CoFace
//
//  Created by Mor Goren on 09/01/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

//Mor Goren Unit
import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController{
    
    var mode: String! = "login"
    var mDatabase: DatabaseReference!
    @IBOutlet weak var BackgraoundImage: UIImageView!
    @IBOutlet weak var WarningLable: UILabel!
    @IBOutlet weak var LogInButton: RoundButton!
    @IBOutlet weak var SignInButton: RoundButton!
    @IBOutlet weak var CityTextField: RoundTextField!
    @IBOutlet weak var EmailTextField: RoundTextField!
    @IBOutlet weak var PasswordTextField: RoundTextField!
    @IBOutlet weak var ConfirmPasswordTextField: RoundTextField!
    @IBOutlet weak var SignInArrowButton: UIButton!
    @IBOutlet weak var ShowHideCPasswordButton: UIButton!
    @IBOutlet weak var ShowHidePassButton: UIButton!
    @IBOutlet weak var Activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ArrowsButtonSetup(button: SignInArrowButton)
        PasswordTextField.isSecureTextEntry = true
        ConfirmPasswordTextField.isSecureTextEntry = true
        SignInButton.changeLook(bool: false)
        LogInButton.changeLook(bool: true)
        WarningLable.isHidden = true
        ModeChange(mode: mode)
        WarningLableSetup()
        BackgraoundSetup()
        Activity.isHidden = true
    }
    
    @IBAction func LogInButtonAction(_ sender: Any) {
        setClick(buttonShow: LogInButton, buttonHide: SignInButton)
        mode = "login"
        ModeChange(mode: mode)
        
    }
    
    @IBAction func SignInButtonAction(_ sender: Any) {
        setClick(buttonShow: SignInButton, buttonHide: LogInButton)
        mode = "signup"
        ModeChange(mode: mode)
    }
    
    @IBAction func ShowHidePassAction(_ sender: Any) {
        ShowHide(button: ShowHidePassButton, textField: PasswordTextField)
        
    }
    
    @IBAction func ShowHideCPassAction(_ sender: Any) {
        ShowHide(button: ShowHideCPasswordButton, textField: ConfirmPasswordTextField)
    }
    
    @IBAction func ArrowAction(_ sender: Any) {
        if mode == "signup"{
            if CheckSignUp(){
                if SignUp(){
                //print("email", EmailTextField.text)
                BranchData.shared.getID(email: EmailTextField.text ?? "defult")
            }
        }
        }
        if mode == "login"{
            if CheckLogin(){
                if LogIn(){
                //print("email", EmailTextField.text)
                BranchData.shared.getID(email: EmailTextField.text ?? "defult")
            }
            }
        }
        
        if Activity.isAnimating != true{
            blurdView()
            Activity.startAnimating()
            Activity.isHidden = false
        }
        print(BranchData.shared.branch)
        NavigateToManagerMenu()
        
       /* if BranchData.shared.branch != nil {
            Activity.stopAnimating()
            Activity.isHidden = true
        }*/
    }
    
    private func NavigateToManagerMenu(){
        let MainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let MainNavigationVC = MainStoryboard.instantiateViewController(withIdentifier: "MianNavigationController") as? MainNavigationController else{return}
        print("topviewcontroller", MainNavigationVC.topViewController!)
        print("viewControllers", MainNavigationVC.viewControllers)
        MainNavigationVC.topViewController
        present(MainNavigationVC, animated: true, completion: nil)
    }
    
    private func ModeChange(mode : String){
        if mode == "login" {
            CityTextField.isHidden = true
            ConfirmPasswordTextField.isHidden = true
            ShowHideCPasswordButton.isHidden = true
            CleanField()
        }
        if mode == "signup" {
            CityTextField.isHidden = false
            ConfirmPasswordTextField.isHidden = false
            ShowHideCPasswordButton.isHidden = false
            CleanField()
        }
    }

    private func CleanField(){
        EmailTextField.text = ""
        CityTextField.text = ""
        PasswordTextField.text = ""
        ConfirmPasswordTextField.text = ""
    }
    
    private func setClick(buttonShow : RoundButton, buttonHide : RoundButton){
        buttonShow.changeLook(bool: true)
        buttonHide.changeLook(bool: false)
    }
    
    private func ArrowsButtonSetup(button : UIButton){
        button.frame.size = CGSize(width: 50, height: 50)
    }
    
    private func ShowHide(button: UIButton, textField: UITextField){
        if button.currentImage == UIImage(named: "icons8-eye-30"){
            textField.isSecureTextEntry = false
            button.setImage(UIImage(named: "icons8-invisible-30"), for: .normal)        }
        else{
            textField.isSecureTextEntry = true
            button.setImage(UIImage(named: "icons8-eye-30"), for: .normal)
        }
    }
    
    private func CheckLogin() -> Bool{
        var flag = true
        if WhatEmpty() {
            flag = LogIn()
                
        }
        else{
            WarningLable.isHidden = false
            flag = false
        }
        return flag
    }
    
    private func CheckSignUp() -> Bool{
        var flag = true
        if SWhatEmpty(){
            if (EmailTextField.text?.isValidEmail())!{
                if ConfriemPasswords(){
                    if SignUp(){
                        flag = true
                    }
                }
                else{
                    WarningLable.isHidden = false
                    flag = false
                }
            }
            else{
                WarningLable.text = "Not a valid Email"
                WarningLable.isHidden = false
                flag = false
            }
        }
        else{
            WarningLable.isHidden = false
            flag = false
        }
        return flag
    }
    
    private func WhatEmpty()-> Bool{
        var answer = true
        WarningLable.text = "The following fields can't be empty: \n"
        if (EmailTextField.text?.isEmpty)! {
            WarningLable.text?.append(contentsOf: " * Email \n")
            answer = false
        }
        if (PasswordTextField.text?.isEmpty)!{
            WarningLable.text?.append(contentsOf: " * Password \n")
            answer = false
        }
        return answer
    }
    
    private func SWhatEmpty() -> Bool{
        var answer = true
        WarningLable.text = "The following fields can't be empty: \n"
        if (CityTextField.text?.isEmpty)!{
            WarningLable.text?.append(contentsOf: " * City \n")
            answer = false
        }
        if (EmailTextField.text?.isEmpty)! {
            WarningLable.text?.append(contentsOf:" * Email \n")
            answer = false
        }
        if (PasswordTextField.text?.isEmpty)! {
            WarningLable.text?.append(contentsOf:" * Password \n")
            answer = false
        }
        if (ConfirmPasswordTextField.text?.isEmpty)! {
            WarningLable.text?.append(contentsOf:" * Confirm Password \n")
            answer = false
        }
        return answer
    }
    
    private func ConfriemPasswords() -> Bool{
        var answer = true
        if PasswordTextField.text !=  ConfirmPasswordTextField.text{
            WarningLable.text = "The passwords are not the same"
            answer = false
        }
        return answer
    }
    
    private func WarningLableSetup() {
        WarningLable.textColor = UIColor.red
    }
    
    private func SignUp() -> Bool{
        guard let email = EmailTextField.text else {return false}
        guard let password = PasswordTextField.text else {return false}
        let branch: [String: Any] = ["Email" : email, "City" : CityTextField.text!]
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                print("User created")
            }
        }
        guard  let uid = Auth.auth().currentUser?.uid else {return false}
        let ref = Database.database().reference().root.child("Branches/\(uid)")
        ref.setValue(branch) { error, ref in
            if error != nil {
                print(error!)
            }
        }
        return true
    }
    
    private func LogIn() -> Bool{
        var flag = true
        guard let email = EmailTextField.text else {return false}
        guard let password = PasswordTextField.text else {return false}
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if user != nil && error == nil {
                //self.dismiss(animated: false, completion: nil)
            }
            else{
                print ("Log in error")
                flag = false
            }
        }
        return flag
    }
    
    private func BackgraoundSetup(){
        if UIDevice.current.orientation.isLandscape {
            BackgraoundImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height)
        }
        else{
        BackgraoundImage.frame = CGRect(x: 0, y: 0, width: 2*(UIScreen.main.bounds.width/3), height: UIScreen.main.bounds.height)
        }
        
    }
    
    private func blurdView(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.7
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        BackgraoundSetup()
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
        }
    }
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

