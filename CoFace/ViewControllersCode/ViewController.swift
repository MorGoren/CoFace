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

class ViewController: UIViewController, UITextFieldDelegate{
    
    var mDatabase: DatabaseReference!
    var places = [CGRect]()
    var city: UITextField!
    var email: UITextField!
    var password: UITextField!
    var confirm: UITextField!
    var code: UITextField!
    var enter: UIButton!
    var warning: UILabel!
    @IBOutlet weak var BackgraoundImage: UIImageView!
    @IBOutlet weak var optionControl: UISegmentedControl!
    @IBAction func optionAction(_ sender: UISegmentedControl) {
        removeAllViews()
        switch sender.selectedSegmentIndex {
        case 2:
            signViewSetup()
            break
        case 1:
            print("my random->", randomCode())
            logViewSetup()
            break
        case 0:
            codeViewSetup()
            break
        default:
            signViewSetup()
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let x = optionControl.frame.origin.x
        let y = optionControl.frame.origin.y  + optionControl.frame.height + 20
        let width = optionControl.frame.width
        let height = optionControl.frame.height
        places.append(CGRect(x: x, y: y, width: width, height: height))
        places.append(CGRect(x: x, y: height + y + 10, width: width, height: height))
        places.append(CGRect(x: x, y:  2 * height + y + 20, width: width, height: height))
        places.append(CGRect(x: x, y: 3 * height + y + 30, width: width, height: height))
        places.append(CGRect(x: x, y: 4 * height + y + 40, width: CGFloat(75), height: CGFloat(75)))
        places.append(CGRect(x: x + 100, y: 4 * height + y + 40, width: width , height: 3 * height))

        city = addTextField(place: 0, fontSize: 20.0, placeholder: "עיר", secure: false)
        email = addTextField(place: 1, fontSize: 20.0, placeholder: "מייל", secure: false)
        password = addTextField(place: 2, fontSize: 20.0, placeholder: "סיסמא", secure: true)
        confirm = addTextField(place: 3, fontSize: 20.0, placeholder: "סיסמא", secure: true)
        code = addTextField(place: 0, fontSize: 20.0, placeholder: "קוד", secure: false)
        enter = addButton()
        warning = addLabel()
        self.view.addSubview(city)
        self.view.addSubview(email)
        self.view.addSubview(password)
        self.view.addSubview(confirm)
        self.view.addSubview(enter)
        self.view.addSubview(warning)
        //logView.isHidden = true
        
        /*ArrowsButtonSetup(button: SignInArrowButton)
        PasswordTextField.isSecureTextEntry = true
        ConfirmPasswordTextField.isSecureTextEntry = true
        SignInButton.changeLook(bool: false)
        LogInButton.changeLook(bool: true)
        WarningLable.isHidden = true
        ModeChange(mode: mode)
        WarningLableSetup()
        BackgraoundSetup()*/
    }
    
    private func logViewSetup(){
        email.frame = places[0]
        password.frame = places[1]
        self.view.addSubview(email)
        self.view.addSubview(password)
        self.view.reloadInputViews()
     }
    
    private func signViewSetup(){
        city.frame = places[0]
        email.frame = places[1]
        password.frame = places[2]
        confirm.frame = places[3]
        self.view.addSubview(city)
        self.view.addSubview(email)
        self.view.addSubview(password)
        self.view.addSubview(confirm)
        self.view.reloadInputViews()
    }
    
    private func codeViewSetup(){
        code.frame = places[0]
        self.view.addSubview(code)
        self.view.reloadInputViews()
    }
    
    private func addTextField(place: Int, fontSize: Float, placeholder: String , secure: Bool) -> UITextField{
        let textField =  UITextField(frame: places[place])
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.textAlignment = .right
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.isSecureTextEntry = secure
        textField.tag = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textColor = .black
        return textField
    }
    
    private func removeAllViews(){
        for view in self.view.subviews{
            if view.tag == 1{
                view.removeFromSuperview()
            }
        }
    }
    
    private func addLabel() -> UILabel{
        let label = UILabel(frame: places[5])
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: CGFloat(20.0))
        label.numberOfLines = 8
        label.isHidden = true
        return label
    }
    
    private func addButton() -> UIButton{
        let button = UIButton(frame: places[4])
        button.setImage(UIImage(named: "login"), for: .normal)
        button.addTarget(self, action: #selector(enterAction), for: .touchUpInside)
        button.layer.cornerRadius = button.frame.size.height / 2
        button.backgroundColor = .clear
        return button
    }
    
    @objc func enterAction(sender: UIButton){
        sender.pulseAnimation()
        switch optionControl.selectedSegmentIndex{
        case 2:
            signupTrigger()
            break
        case 1:
            loginTrigger()
            break
        case 0:
            codeTrigger()
            break
        default:
            break
        }
    }
    /*
    @IBAction func LogInButtonAction(_ sender: Any) {
        setClick(buttonShow: LogInButton, buttonHide: SignInButton, buttonHide2: CodeButton)
        mode = "login"
        ModeChange(mode: mode)
        
    }
    
    @IBAction func SignInButtonAction(_ sender: Any) {
        setClick(buttonShow: SignInButton, buttonHide: LogInButton, buttonHide2: CodeButton)
        mode = "signup"
        ModeChange(mode: mode)
    }
    @IBAction func codeButtonAction(_ sender: Any) {
        setClick(buttonShow: CodeButton, buttonHide: LogInButton, buttonHide2: SignInButton)
        mode = "code"
        ModeChange(mode: mode)
    }
    
    @IBAction func ShowHidePassAction(_ sender: Any) {
        ShowHide(button: ShowHidePassButton, textField: PasswordTextField)
        
    }
    
    @IBAction func ShowHideCPassAction(_ sender: Any) {
        ShowHide(button: ShowHideCPasswordButton, textField: ConfirmPasswordTextField)
    }
    
    @IBAction func logShowHideAction(_ sender: Any) {
        ShowHide(button: logShowHide, textField: logPassword)
    }
    */
    private func signupTrigger(){
        if CheckSignUp(){
            if SignUp(){
                BranchData.shared.getID(email: email.text?.lowercased() ?? "defult", completion: { check in
                    if check == true{
                        self.NavigateToManagerMenu()
                    }
                    else{
                        self.warning.text = "oop! something is not right"
                        self.warning.isHidden = false
                    }
                })
            }
        }
    }
    
     private func loginTrigger(){
        CheckLogin(completion: { check in
                if check == true{
                    BranchData.shared.getID(email: self.email.text?.lowercased() ?? "defult", completion: { check in
                        if check == true{
                            self.NavigateToManagerMenu()
                        }
                    })
                }
            else {
                self.warning.text = "oop! something is not right"
                self.warning.isHidden = false
            }
        })
    }
    
    private func codeTrigger(){
        BranchData.shared.getCode(code: code.text!) { check  in
            if check == true{
                self.NavigateToManagerMenu()
            }
            else {
                self.warning.text = "oop! something is not right"
                self.warning.isHidden = false
            }
        }
    }
    
    private func NavigateToManagerMenu(){
        let MainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let MainNavigationVC = MainStoryboard.instantiateViewController(withIdentifier: "MianNavigationController") as? MainNavigationController else{return}
        //MainNavigationVC.topViewController
        present(MainNavigationVC, animated: true, completion: nil)
    }
    
    private func NavigateToActivity(){
        let MainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let MainNavigationVC = MainStoryboard.instantiateViewController(withIdentifier: "Activity") as? StartView else{return}
        //MainNavigationVC.topViewController
        present(MainNavigationVC, animated: true, completion: nil)

    }
    
    private func CleanField(){
        email.text = ""
        city.text = ""
        password.text = ""
        confirm.text = ""
        code.text = " "
        warning.text = " "
    }
    
    /*private func ShowHide(button: UIButton, textField: UITextField){
        if button.currentImage == UIImage(named: "hide"){
            textField.isSecureTextEntry = false
            button.setImage(UIImage(named: "show"), for: .normal)        }
        else{
            textField.isSecureTextEntry = true
            button.setImage(UIImage(named: "hide"), for: .normal)
        }
    }*/
    
    private func CheckLogin(completion : @escaping ((_ check: Bool?)->())){
        if WhatEmpty() {
            LogIn(){ check in
                    completion(check)
            }
        }
        else{
            warning.isHidden = false
        }
    }
    
    private func CheckSignUp() -> Bool{
        var flag = true
        if SWhatEmpty(){
            if (email.text?.isValidEmail())!{
                if ConfriemPasswords(){
                    if SignUp(){
                        flag = true
                    }
                }
                else{
                    warning.isHidden = false
                    flag = false
                }
            }
            else{
                warning.text = "Not a valid Email"
                warning.isHidden = false
                flag = false
            }
        }
        else{
            warning.isHidden = false
            flag = false
        }
        return flag
    }
    
    private func WhatEmpty()-> Bool{
        var answer = true
        warning.text = "The following fields can't be empty: \n"
        if (email.text?.isEmpty)! {
            warning.text?.append(contentsOf: " * Email \n")
            answer = false
        }
        if (password.text?.isEmpty)!{
            warning.text?.append(contentsOf: " * Password \n")
            answer = false
        }
        return answer
    }
    
    private func SWhatEmpty() -> Bool{
        var answer = true
        warning.text = "The following fields can't be empty: \n"
        if (city.text?.isEmpty)!{
            warning.text?.append(contentsOf: " * City \n")
            answer = false
        }
        if (email.text?.isEmpty)! {
            warning.text?.append(contentsOf:" * Email \n")
            answer = false
        }
        if (password.text?.isEmpty)! {
            warning.text?.append(contentsOf:" * Password \n")
            answer = false
        }
        if (confirm.text?.isEmpty)! {
            warning.text?.append(contentsOf:" * Confirm Password \n")
            answer = false
        }
        return answer
    }
    
    private func ConfriemPasswords() -> Bool{
        var answer = true
        if password.text !=  confirm.text{
            password.text = "The passwords are not the same"
            answer = false
        }
        return answer
    }
    
    private func SignUp() -> Bool{
        guard let Email = email.text?.lowercased() else {return false}
        guard let Password = password.text?.lowercased() else {return false}
        let myCode =  randomCode()
        let branch: [String: Any] = ["Email" : Email, "City" : city.text!, "Code": myCode]
        
        Auth.auth().createUser(withEmail: Email, password: Password) { user, error in
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
    
    private func LogIn(completion: @escaping ((_ check: Bool?)->())){
        Auth.auth().signIn(withEmail: email.text ?? "defult", password: password.text ?? "defult") { user, error in
            if user != nil && error == nil {
                    completion(true)
            }
            else{
                completion(false)
            }
        }
    }
    
    private func randomCode() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<6).map{ _ in letters.randomElement()! })
    }
    /*private func BackgraoundSetup(){
        if UIDevice.current.orientation.isLandscape {
            BackgraoundImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height)
        }
        else{
        BackgraoundImage.frame = CGRect(x: 0, y: 0, width: 2*(UIScreen.main.bounds.width/3), height: UIScreen.main.bounds.height)
        }
    }*/
    
    private func blurdView(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.7
        blurEffectView.frame = view.bounds
        blurEffectView.tag = 1
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    /*override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
        }
    }*/
}

extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
