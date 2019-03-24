import UIKit
import Firebase
import FirebaseStorage

class addGuessViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var userEmail: String!
    var ProtocolMess: String!
    var ImagePicker:  UIImagePickerController!
    @IBOutlet weak var BackgroundImage: UIImageView!
    @IBOutlet weak var FirstNameTextField: RoundTextField!
    @IBOutlet weak var LastNameTextFielld: RoundTextField!
    @IBOutlet weak var EyeMonitorLable: UILabel!
    @IBOutlet weak var EyeMonitorSwitch: UISwitch!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var WarningLable: UILabel!
    @IBOutlet weak var ImagePickButton: UIButton!
    @IBOutlet weak var FieldsView: UIView!
    @IBOutlet weak var OrderLable: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func AddButtonAction(_ sender: Any) {
        if CheckWhatEmpty() {
            let firstName = FirstNameTextField.text
            let lastName =  LastNameTextFielld.text
            var eye : Bool!
            if EyeMonitorSwitch.isOn {
                eye = true
            }
            else{
                eye = false
            }
            let guest: [String : Any] = ["first name" : firstName!, "last name" : lastName!, "eye" : eye]
            let image = ImagePickButton.currentImage!
            activitySetup()
            BranchData.shared.addGuest(guest: guest, image: image){ check in
                if check != "no" {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.navigationController?.popViewController(animated: true)
                }
                else {
                    sleep(1)
                }
            }
            
        }
        else{
            WarningLable.isEnabled = true
        }
    }
    
    
    @IBAction func ImagePickAction(_ sender: Any) {
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
        BackgroundSetup()
        ImagePickSetup()
        WrningSetup()
        activityIndicator.frame.size = CGSize(width: 50, height: 50)
        activityIndicator.isHidden = true
        //print("userid in aggGuest", userid)
    }
    
    private func activitySetup(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    private func WrningSetup(){
        WarningLable.textColor = UIColor.red
        WarningLable.isHidden = true
    }
    private func BackgroundSetup(){
        BackgroundImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    private func WarningLableSetup(){
        WarningLable.textColor = UIColor.red
    }
    
    private func ImagePickSetup(){
        ImagePickButton.layer.cornerRadius = 0.5 * ImagePickButton.bounds.size.width
        ImagePickButton.clipsToBounds = true
        ImagePickButton.backgroundColor =  UIColor.clear
    }
    
    private func ViewsSetup(){
        OrderLable.layer.cornerRadius = 20
        FieldsView.layer.cornerRadius = 20
    }
    
    private func CheckWhatEmpty() -> Bool{
        WarningLable.text = "The next field can't be empty: \n"
        if (FirstNameTextField.text?.isEmpty)!{
            WarningLable.text?.append(contentsOf: " * First Name \n")
            if (LastNameTextFielld.text?.isEmpty)! {
                WarningLable.text?.append(contentsOf: " * Last Name \n")
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
            ImagePickButton.setImage(pickedImage, for: .normal)
            ImagePickButton.layer.borderWidth = 10
            ImagePickButton.layer.borderColor = UIColor.black.cgColor
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
