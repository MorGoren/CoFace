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
    
    @IBOutlet weak var background: UIImageView!
    var mDatabase: DatabaseReference!
    var places = [CGRect]()
    var city: UITextField!
    var email: UITextField!
    var password: UITextField!
    var siemail: UITextField!
    var sipassword: UITextField!
    var confirm: UITextField!
    var code: UITextField!
    var enter: UIButton!
    var warning: UILabel!
    var segment: UISegmentedControl!
    var frame = UIScreen.main.bounds
    var textView = UIView()
    var logView = UIView()
    var signView = UIView()
    var codeView = UIView()
    var font : Int!
    
    @objc func segmentAction(_ sender: UISegmentedControl) {
        //removeAllViews()
        switch sender.selectedSegmentIndex {
        case 0:
            signViewSetup()
            break
        case 1:
            print("my random->", randomCode())
            logViewSetup()
            break
        case 2:
            codeViewSetup()
            break
        default:
            signViewSetup()
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let height = view.frame.height/28
        setFont()
        segment = addSegmetControl()
        email = addTextField(placeholder: "מייל", secure: false)
        password = addTextField(placeholder: "סיסמא", secure: true)
        siemail = addTextField(placeholder: "מייל", secure: false)
        sipassword = addTextField(placeholder: "סיסמא", secure: true)
        city = addTextField(placeholder: "עיר", secure: false)
        confirm = addTextField(placeholder: "אימות סיסמא", secure: true)
        code = addTextField(placeholder: "הכנס קוד", secure: false)
        enter = addButton()
        warning = addLabel()
        self.view.addSubview(textView)
        self.view.addSubview(enter)
        self.view.addSubview(warning)
        self.textView.addSubview(segment)
        self.textView.addSubview(logView)
        self.textView.addSubview(signView)
        self.textView.addSubview(codeView)
        self.logView.addSubview(email)
        self.logView.addSubview(password)
        self.signView.addSubview(siemail)
        self.signView.addSubview(sipassword)
        self.signView.addSubview(city)
        self.signView.addSubview(confirm)
        self.codeView.addSubview(code)
        self.view.backgroundColor = UIColor(red: 228/255, green: 230/255, blue: 234/255, alpha: 1.0)
        logView.isHidden = true
        signView.isHidden = false
        codeView.isHidden = true
        enter.translatesAutoresizingMaskIntoConstraints = false
        warning.translatesAutoresizingMaskIntoConstraints = false
        code.translatesAutoresizingMaskIntoConstraints = false
        codeView.translatesAutoresizingMaskIntoConstraints = false
        sipassword.translatesAutoresizingMaskIntoConstraints = false
        siemail.translatesAutoresizingMaskIntoConstraints = false
        city.translatesAutoresizingMaskIntoConstraints = false
        confirm.translatesAutoresizingMaskIntoConstraints = false
        signView.translatesAutoresizingMaskIntoConstraints = false
        logView.translatesAutoresizingMaskIntoConstraints = false
        password.translatesAutoresizingMaskIntoConstraints = false
        email.translatesAutoresizingMaskIntoConstraints = false
        segment.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        background.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textView.backgroundColor = .clear
        textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -0.5*height).isActive = true
        textView.leftAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        textView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        segment.heightAnchor.constraint(equalToConstant: height).isActive = true
        segment.topAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        segment.widthAnchor.constraint(equalToConstant: textView.frame.width).isActive = true
        segment.leftAnchor.constraint(equalTo: textView.leftAnchor).isActive = true
        segment.rightAnchor.constraint(equalTo: textView.rightAnchor).isActive = true
        //logview
        logView.backgroundColor = .clear
        logView.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: height*0.25).isActive = true
        logView.widthAnchor.constraint(equalToConstant: textView.frame.width).isActive = true
        logView.rightAnchor.constraint(equalTo: textView.rightAnchor).isActive = true
        logView.leftAnchor.constraint(equalTo: textView.leftAnchor).isActive = true
        logView.bottomAnchor.constraint(equalTo: textView.bottomAnchor).isActive = true
        email.topAnchor.constraint(equalTo: logView.topAnchor).isActive = true
        email.widthAnchor.constraint(equalToConstant: logView.frame.width).isActive = true
        email.rightAnchor.constraint(equalTo: logView.rightAnchor).isActive = true
        email.leftAnchor.constraint(equalTo: logView.leftAnchor).isActive = true
        email.heightAnchor.constraint(equalToConstant: height*0.90).isActive = true
        password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: height*0.25).isActive = true
        password.widthAnchor.constraint(equalToConstant: email.frame.width).isActive = true
        password.rightAnchor.constraint(equalTo: email.rightAnchor).isActive = true
        password.leftAnchor.constraint(equalTo: email.leftAnchor).isActive = true
        password.heightAnchor.constraint(equalToConstant: height*0.90).isActive = true
        //signView
        signView.backgroundColor = .clear
        signView.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: height*0.25).isActive = true
        signView.widthAnchor.constraint(equalToConstant: textView.frame.width).isActive = true
        signView.rightAnchor.constraint(equalTo: textView.rightAnchor).isActive = true
        signView.leftAnchor.constraint(equalTo: textView.leftAnchor).isActive = true
        signView.bottomAnchor.constraint(equalTo: textView.bottomAnchor).isActive = true
        city.topAnchor.constraint(equalTo: signView.topAnchor).isActive = true
        city.widthAnchor.constraint(equalToConstant: signView.frame.width).isActive = true
        city.rightAnchor.constraint(equalTo: signView.rightAnchor).isActive = true
        city.leftAnchor.constraint(equalTo: signView.leftAnchor).isActive = true
        city.heightAnchor.constraint(equalToConstant: height*0.90).isActive = true
        siemail.topAnchor.constraint(equalTo: city.bottomAnchor, constant: height*0.25).isActive = true
        siemail.widthAnchor.constraint(equalToConstant: signView.frame.width).isActive = true
        siemail.rightAnchor.constraint(equalTo: signView.rightAnchor).isActive = true
        siemail.leftAnchor.constraint(equalTo: signView.leftAnchor).isActive = true
        siemail.heightAnchor.constraint(equalToConstant: height*0.90).isActive = true
        sipassword.topAnchor.constraint(equalTo: siemail.bottomAnchor, constant: height*0.25).isActive = true
        sipassword.widthAnchor.constraint(equalToConstant: signView.frame.width).isActive = true
        sipassword.rightAnchor.constraint(equalTo: signView.rightAnchor).isActive = true
        sipassword.leftAnchor.constraint(equalTo: signView.leftAnchor).isActive = true
        sipassword.heightAnchor.constraint(equalToConstant: height*0.90).isActive = true
        confirm.topAnchor.constraint(equalTo: sipassword.bottomAnchor, constant: height*0.25).isActive = true
        confirm.widthAnchor.constraint(equalToConstant: signView.frame.width).isActive = true
        confirm.rightAnchor.constraint(equalTo: signView.rightAnchor).isActive = true
        confirm.leftAnchor.constraint(equalTo: signView.leftAnchor).isActive = true
        confirm.heightAnchor.constraint(equalToConstant: height*0.90).isActive = true
        //codeview
        codeView.backgroundColor = .clear
        codeView.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: height*0.25).isActive = true
        codeView.widthAnchor.constraint(equalToConstant: textView.frame.width).isActive = true
        codeView.rightAnchor.constraint(equalTo: textView.rightAnchor).isActive = true
        codeView.leftAnchor.constraint(equalTo: textView.leftAnchor).isActive = true
        codeView.bottomAnchor.constraint(equalTo: textView.bottomAnchor).isActive = true
        code.topAnchor.constraint(equalTo: codeView.topAnchor).isActive = true
        code.widthAnchor.constraint(equalToConstant: codeView.frame.width).isActive = true
        code.rightAnchor.constraint(equalTo: codeView.rightAnchor).isActive = true
        code.leftAnchor.constraint(equalTo: codeView.leftAnchor).isActive = true
        code.heightAnchor.constraint(equalToConstant: height*0.75).isActive = true
        code.backgroundColor = .white
        //enterButton
        enter.topAnchor.constraint(equalTo: textView.bottomAnchor).isActive = true
        enter.rightAnchor.constraint(equalTo: textView.rightAnchor).isActive = true
        enter.widthAnchor.constraint(equalToConstant: view.frame.width/8).isActive = true
        enter.heightAnchor.constraint(equalToConstant: view.frame.width/8).isActive = true
        warning.topAnchor.constraint(equalTo: textView.bottomAnchor).isActive = true
        warning.rightAnchor.constraint(equalTo: enter.leftAnchor).isActive = true
        warning.leftAnchor.constraint(equalTo: textView.leftAnchor).isActive = true
    }
    
    private func logViewSetup(){
        logView.isHidden = false
        signView.isHidden = true
        codeView.isHidden = true
     }
    
    private func signViewSetup(){
        logView.isHidden = true
        signView.isHidden = false
        codeView.isHidden = true
    }
    
    private func codeViewSetup(){
        logView.isHidden = true
        signView.isHidden = true
        codeView.isHidden = false
    }
    
    private func addSegmetControl()-> UISegmentedControl{
        let items = ["הרשמה", "התחברות", "קוד"]
        let segment = UISegmentedControl(items: items)
        let fo = UIFont.boldSystemFont(ofSize: CGFloat(font))
        segment.setTitleTextAttributes([NSAttributedString.Key.font: fo], for: .normal)
        segment.selectedSegmentIndex = 0
        segment.backgroundColor = .clear
        segment.layer.cornerRadius = 5.0
        segment.addTarget(self, action: #selector(segmentAction), for: .valueChanged)
        return segment
    }
    
    private func addTextField(placeholder: String , secure: Bool) -> UITextField{
        let textField =  UITextField()
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: CGFloat(font))
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
        for view in textView.subviews{
            if view.tag == 1{
                view.removeFromSuperview()
            }
        }
    }
    
    private func addLabel() -> UILabel{
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: CGFloat(font))
        label.numberOfLines = 8
        label.isHidden = true
        return label
    }
    
    private func addButton() -> UIButton{
        let button = UIButton()
        button.setImage(UIImage(named: "login"), for: .normal)
        button.addTarget(self, action: #selector(enterAction), for: .touchUpInside)
        button.layer.cornerRadius = button.frame.size.height / 2
        button.backgroundColor = .clear
        return button
    }
    
    @objc func enterAction(sender: UIButton){
        sender.pulseAnimation()
        switch segment.selectedSegmentIndex{
        case 0:
            signupTrigger()
            break
        case 1:
            loginTrigger()
            break
        case 2:
            codeTrigger()
            break
        default:
            break
        }
    }
    
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
        if (siemail.text?.isEmpty)! {
            warning.text?.append(contentsOf:" * Email \n")
            answer = false
        }
        if (sipassword.text?.isEmpty)! {
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
    
    private func blurdView(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.7
        blurEffectView.frame = view.bounds
        blurEffectView.tag = 1
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    private func setFont(){
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            font = 13
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

extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
