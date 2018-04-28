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

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
//    var newUser: AppUser!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        newUser = AppUser()

    }
    
    func showCameraOrPhotoLibraryAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: nil)
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: nil)
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
                    }
                }
            }
            
        }
        else {
            self.showErrorAlert(error: "Make sure you use a valid school email.")
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backToInitialVC", sender: self)
    }
    
    

}
