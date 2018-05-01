//
//  SignUpViewController.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/21/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {


    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
//    var newUser: AppUser!
    
    var activeTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        usernameTextField.delegate = self
        let center: NotificationCenter = NotificationCenter.default;
        center.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
//        usernameTextField.delegate = self
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolbar.setItems([doneButton], animated: true)
        emailTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
        usernameTextField.inputAccessoryView = toolbar
        
        loading.isHidden = true
    }
    
//    deinit {
//        //stop listening for keyboard
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
//    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
//    @objc func keyboardWillChange(notification: Notification) {
//        print("Keyboard will show \(notification.name.rawValue)")
//
//        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//            return
//            }
//        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame {
//               view.frame.origin.y = -keyboardRect.height
//        } else {
//            view.frame.origin.y = 0
//        }
//    }
    
    @objc func keyboardDidShow(notification: Notification) {
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.size.height - keyboardSize.height
        let editingTextFieldY: CGFloat! = self.usernameTextField!.frame.origin.y
        if self.view.frame.origin.y >= 0 {
        if editingTextFieldY > keyboardY - 60 {
            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editingTextFieldY! - (keyboardY - 60)), width: self.view.bounds.width, height: self.view.bounds.height) }, completion: nil)
        }
        }
    }
    
    
    @objc func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            }, completion: nil)
    }
    

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTextField = textField
        return true
    }
    
    func showCameraOrPhotoLibraryAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.accessCamera()
            
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) {
            _ in self.accessLibrary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        profileImage.image = selectedImage
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func accessLibrary() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func accessCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            showErrorAlert(error: "Camera not Available")
        }
    }
    
    func showErrorAlert(error:String){
        let alert = UIAlertController(title: "Try again?", message: error, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func isValidSchoolEmail(email:String) -> Bool {
        return email.hasSuffix("@bc.edu")
        //return true
    }
    
    @IBAction func doneKeyPressedforemail(_ sender: UITextField) {
        emailTextField.resignFirstResponder()
    }
    
    @IBAction func doneKeyPressedforpassword(_ sender: UITextField) {
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func doneKeyPressedforusername(_ sender: UITextField) {
        usernameTextField.resignFirstResponder()
    }
    @IBAction func profileImageTapped(_ sender: UITapGestureRecognizer) {
        showCameraOrPhotoLibraryAlert()
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        loading.isHidden = false
        loading.startAnimating()
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let username = usernameTextField.text else {return}
        if isValidSchoolEmail(email: email) {
            Auth.auth().createUser(withEmail: email, password: password) {
                (user, error) in
                
                Auth.auth().currentUser?.sendEmailVerification(completion: { (error:Error?) in
                    if error == nil{
                        print("Verification email sent!")
//                        self.newUser.saveData()
                    }
                }) 
                
                if error == nil {
                    self.performSegue(withIdentifier: "goToVerifyVC", sender:nil)
                    FirebaseManager.isLoggedIn = true
                    FirebaseManager.logInInfo = LogInInfo.init(email:email, password:password)
                    FirebaseManager.logInInfo?.saved = false
                    print("Unverified account created")
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = username
                    print("The sketchy username code executed")
                    
                }else{
                    DispatchQueue.main.async {
                        //self.progress.stopAnimating()
                        self.showErrorAlert(error: FirebaseManager.returnErrorMessages(error: error!))
                        self.loading.isHidden = true
                    }
                }
                guard let img = self.profileImage.image else {
                    
                    print("image must be selected")
                    
                    return
                }
                
                if let imgData = UIImageJPEGRepresentation(img, 0.2) {
                    
                    let imgUid = NSUUID().uuidString
                    
                    let metadata = StorageMetadata()
                    
                    metadata.contentType = "img/jpeg"
                    Storage.storage().reference().child(imgUid).putData(imgData, metadata: metadata) { (metadata, error) in
                        
                        if error == nil {
                            
                            print("did not upload img")
                            
                        } else {
                            
                            print("uploaded")
                            
                            let downloadURl = metadata?.downloadURL()?.absoluteString
                            
                            if let url = downloadURl {
                                let setLocation = Database.database().reference().child("profileImage").child(username)
                                setLocation.setValue(url)
                            }
                        }
                    }
                }
            }
            
        }
        else {
            self.showErrorAlert(error: "Make sure you use a valid school email.")
            loading.isHidden = true
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backToInitialVC", sender: self)
    }
    
    

}
