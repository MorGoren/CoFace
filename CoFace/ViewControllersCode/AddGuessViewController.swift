import UIKit
import Firebase
import FirebaseStorage

class addGuessViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var userEmail: String!
    var ProtocolMess: String!
    var ImagePicker:  UIImagePickerController!
    @IBOutlet weak var BackgroundImage: UIImageView!
    var last: UITextField!
    var first: UITextField!
    var eyeLabel: UILabel!
    var eyeSwich: UISwitch!
    var add: UIButton!
    var order: UILabel!
    var profile: UIButton!
    var warning: UILabel!
    var frame = UIScreen.main.bounds
    var font: Int!
    var guestEdit: guestData!
    @objc func addAction() {
        add.pulseAnimation()
        if CheckWhatEmpty() {
            let firstName = first.text
            let lastName =  last.text
            var eye : Bool!
            if eyeSwich.isOn {
                eye = true
            }
            else{
                eye = false
            }
            let guest: [String : Any] = ["first name" : firstName!, "last name" : lastName!, "eye" : eye!]
            let image = profile.currentImage!
            activitySetup()
            if guestEdit == nil{
                BranchData.shared.addGuest(guest: guest, image: image){ check in
                    if check != "no" {
                        self.navigationController?.popViewController(animated: true)
                    }
            else {
                sleep(1)
                    }
                }
            }
            else{

            }
            
        }
        else{
            warning.isEnabled = true
        }
    }
    
    
    @objc func profileAction() {
        let imagePicketController = UIImagePickerController()
        imagePicketController.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            (action: UIAlertAction) in
            imagePicketController.sourceType = .camera
            self.present(imagePicketController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Galery", style: .default, handler: { (action:UIAlertAction) in
            imagePicketController.sourceType = .photoLibrary
            self.present(imagePicketController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        self.present(actionSheet, animated: true, completion: nil)
        ImagePickSetup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFont()
        var size = frame.height/5
        var x = frame.maxX/2 - size/2
        let ly = size
        profile = addButton(name: "profile", place: CGRect(x: x, y: size, width: size, height: size))
        profile.addTarget(self, action: #selector(profileAction), for: .touchUpInside)
        var y = 2.05*ly
        order = addLabel(text: "הקש לבחירת תמונה", place: CGRect(x: x, y: y, width: size, height: size/5))
        order.textAlignment = .center
        size = frame.width/2
        x = frame.midX-size/2
        y = 2.05*ly+0.3*ly
        first = addTextField(placeholder: "שם פרטי", secure: false, place: CGRect(x: x, y: y, width: size, height: size/10))
        y = 2.05*ly+0.3*ly+size/10+10
        last = addTextField(placeholder: "שם משפחה", secure: false, place: CGRect(x: x, y: y, width: size, height: size/10))
        y = 2.05*ly+0.3*ly+2*(size/10+10)
        eyeLabel = addLabel(text: "ניטור עיניים?", place: CGRect(x: x+size/2, y: y, width: size/2, height: size/10))
        eyeSwich = addSwitch(place: CGRect(x: x, y: y, width: size/2, height: size/10))
        eyeLabel.textAlignment = .center
        y = 2.05*ly+0.3*ly+3*(size/10+10)
        size = frame.width/10
        add = addButton(name: "add", place: CGRect(x: x, y: y+frame.width/50, width: size, height: size))
        add.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        add.backgroundColor = UIColor(white: 1, alpha: 0.8)
        warning = addLabel(text: "", place: CGRect(x: x+size, y: y, width: 3*size, height: 2*size))
        warning.lineBreakMode = NSLineBreakMode.byWordWrapping
        warning.numberOfLines = 4
        warning.textAlignment = .left
        if guestEdit != nil {
            add.setImage(UIImage(named: "edit"), for: .normal)
            profile.setImage(nil, for: .normal)
            profile.layer.borderColor = UIColor.black.cgColor
            profile.layer.borderWidth = 2
            profile.sd_setBackgroundImage(with: URL(string: guestEdit!.image), for: .normal, completed: nil)
            first.text = guestEdit.first
            last.text = guestEdit.last
            eyeSwich.isOn = (guestEdit.eye != 1)
        }
        BackgroundSetup()
        ImagePickSetup()
        warning.isHidden = true
        self.view.addSubview(profile)
        self.view.addSubview(order)
        self.view.addSubview(first)
        self.view.addSubview(last)
        self.view.addSubview(eyeLabel)
        self.view.addSubview(eyeSwich)
        self.view.addSubview(add)
        self.view.addSubview(warning)
    }
    
    private func activitySetup(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }

    private func BackgroundSetup(){
        BackgroundImage.frame = CGRect(x: frame.minX, y: frame.minY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    private func ImagePickSetup(){
        profile.clipsToBounds = true
        profile.backgroundColor =  UIColor.clear
    }
    
    private func CheckWhatEmpty() -> Bool{
        warning.text = "The next field can't be empty: \n"
        if (first.text?.isEmpty)!{
            warning.text?.append(contentsOf: " * First Name \n")
            if (last.text?.isEmpty)! {
                warning.text?.append(contentsOf: " * Last Name \n")
                return false
            }
            return false
        }
        return true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            profile.setImage(pickedImage, for: .normal)
            profile.layer.borderWidth = 10
            profile.layer.borderColor = UIColor.black.cgColor
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func addLabel(text: String, place: CGRect) -> UILabel{
        let label = UILabel(frame: place)
        label.text = text
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: CGFloat(font))
        label.backgroundColor = UIColor.init(
            white: CGFloat(1.0), alpha: CGFloat(0.80))
        label.layer.cornerRadius = label.frame.height/2
        return label
    }
    
    private func addButton(name: String, place: CGRect) -> UIButton{
        let button = UIButton(frame: place)
        button.setImage(UIImage(named: name), for: .normal)
        button.layer.cornerRadius = button.frame.size.height/2
        button.backgroundColor = .clear
        return button
    }
    
    private func addTextField(placeholder: String , secure: Bool, place: CGRect) -> UITextField{
        let textField =  UITextField(frame: place)
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
        textField.backgroundColor = UIColor.init(
            white: CGFloat(1.0), alpha: CGFloat(0.80))
        return textField
    }
    
    private func addInbranch(){
        
    }
    private func addSwitch(place: CGRect) -> UISwitch{
        let switchDemo = UISwitch(frame: place)
        switchDemo.isOn = false
        switchDemo.setOn(true, animated: false)
        return switchDemo
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
