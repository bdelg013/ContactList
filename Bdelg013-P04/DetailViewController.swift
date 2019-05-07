// PROGRAMMER:  Brian Delgado
// PANTHERID:   6058871
// CLASS:       COP 465501
// INSTRUCTOR:  Steve Luis ECS 282
// ASSIGNMENT:  Program #4
// DUE:         Saturday 10/28/18
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
   
    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet weak var myPicture: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    var editMode: Bool = false
    var addMode: Bool = false
    var currentRow: Int = 0
    var contact: Contact?
    let contactDb = ContactDatabase.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contact = contactDb.contactStorage[contactDb.position]
        fNameTextField.text = contact?.firstName//  contact?.firstName
        lNameTextField.text = contact?.lastName
        emailTextField.text = contact?.email
        phoneTextField.text = contact?.phone
        datePicker.date = contact!.dob
        imagePicker.image = contact?.picture
        self.reloadInputViews()
        navigationController?.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //closes keyboard on tap
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //self.view.endEditing(true)
        return true
    }
    
    @IBAction func uploadPressed(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.cameraCaptureMode = .photo  // or .Video
            imagePicker.modalPresentationStyle = .fullScreen
        }
        else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    } // end pressedCamera
    
    
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        myPicture.image = image
        dismiss(animated: true, completion: nil)
    }
    
    //loads values from view and populates contact
    @IBAction func savePressed(_ sender: Any) {
        contact?.firstName = fNameTextField.text!
        contact?.lastName = lNameTextField.text!
        contact?.email = emailTextField.text!
        contact?.phone = phoneTextField.text!
        contact!.dob = datePicker.date
        contact?.picture = imagePicker.image
        //create new contact or edit a contact
        if(addMode) {
            contactDb.addContact(contact: self.contact!)
        }
        if(editMode) {
            contactDb.contactStorage[currentRow] = contact!
        }
        self.view.endEditing(true)
    }    
}



