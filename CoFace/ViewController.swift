//
//  ViewController.swift
//  CoFace
//
//  Created by Mor Goren on 09/01/2019.
//  Copyright © 2019 MorGoren. All rights reserved.
//

//Mor Goren Unit
import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet weak var BackgraoundImage: UIImageView!
    @IBOutlet weak var WarningLable: UILabel!
    @IBOutlet weak var LogInArrowButton: UIButton!
    @IBOutlet weak var EmailTextField: RoundTextField!
    @IBOutlet weak var PasswordTextField: RoundTextField!
    @IBOutlet weak var LogInButton: RoundButton!
    @IBOutlet weak var SignInButton: RoundButton!
    @IBOutlet weak var CityTextField: RoundTextField!
    @IBOutlet weak var SEmailTextField: RoundTextField!
    @IBOutlet weak var SPasswordTextField: RoundTextField!
    @IBOutlet weak var ConfirmPasswordTextField: RoundTextField!
    @IBOutlet weak var SignInArrowButton: UIButton!
    @IBOutlet weak var ShowHidePasswordButton: UIButton!
    @IBOutlet weak var ShowHideSPasswordButton: UIButton!
    
    @IBOutlet weak var LogInView: UIView!
    @IBOutlet weak var SignInView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ArrowsButtonSetup(button: LogInArrowButton)
        ArrowsButtonSetup(button: SignInArrowButton)
        SignInView.isHidden = true
        SignInButton.changeLook(bool: SignInView.isHidden)
        LogInButton.changeLook(bool: LogInButton.isHidden)
        WarningLable.isHidden = true
        WarningLableSetup()
    }
    
    @IBAction func LogInButtonAction(_ sender: Any) {
        setClick(buttonShow: LogInButton, buttonHide: SignInButton, viewShow: LogInView, viewHide: SignInView)
    }
    
    @IBAction func SignInButtonAction(_ sender: Any) {
        setClick(buttonShow: SignInButton, buttonHide: LogInButton, viewShow: SignInView, viewHide: LogInView)
    }
    
    @IBAction func ShowHideSPasswordAction(_ sender: Any) {
        ShowHide(button: ShowHideSPasswordButton, textField: ConfirmPasswordTextField)
    }
    @IBAction func LogInArrowAction(_ sender: Any) {
        
    }
    
    @IBAction func SignInArrowAction(_ sender: Any) {
        if SCheckWhatEmpty(warning: WarningLable){
            if IsValidEmail(email: SEmailTextField, warning: WarningLable){
                if ConfriemPasswords(warning: WarningLable){
                    WarningLable.text = " "
                    //YOU ARE HERE
                }
            }
        }
        WarningLable.isHidden = false
    }
    
    @IBAction func ShowHidePasswordAction(_ sender: Any) {
        ShowHide(button: ShowHidePasswordButton, textField: PasswordTextField)
    }

    private func setClick(buttonShow : RoundButton, buttonHide : RoundButton, viewShow : UIView, viewHide : UIView){
        viewShow.isHidden = false
        buttonShow.changeLook(bool: viewShow.isHidden)
        viewHide.isHidden = true
        buttonHide.changeLook(bool: viewHide.isHidden)
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
    private func SCheckWhatEmpty(warning: UILabel) -> Bool{
        var answer = true
        var warningText = "The following fields can't be empty: "
        if CityTextField.text == nil{
            warningText.append(" * City")
            answer = false
        }
        if SEmailTextField == nil {
            warningText.append(" * Email")
            answer = false
        }
        if SPasswordTextField == nil {
            warningText.append(" * Password")
            answer = false
        }
        if ConfirmPasswordTextField == nil {
            warningText.append(" * Confirm Password")
            answer = false
        }
        warning.text = warningText
        return answer
    }
    
    private func ConfriemPasswords(warning: UILabel) -> Bool{
        var answer = true
        if SPasswordTextField.text !=  ConfirmPasswordTextField.text{
            warning.text = "The passwords are not the same"
            answer = false
        }
        return answer
    }
    func IsValidEmail(email: UITextField, warning: UILabel) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        var answer = true
        if !emailTest.evaluate(with: email){
            warning.text = "Not a valid Email"
            answer = false
        }
        return answer
    }
    
    private func WarningLableSetup() {
        WarningLable.textColor = UIColor.white
    }
}

