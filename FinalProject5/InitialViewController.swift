//
//  ViewController.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/5/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolbar.setItems([doneButton], animated: true)
        emailTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
        
    }
    
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        if let user = Auth.auth().currentUser {
//            self.performSegue(withIdentifier: "gotoGeneralPollVC", sender: self)
//        }
//    }
    
    func showErrorAlert(error:String){
        let alert = UIAlertController(title: "Try again?", message: error, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func isValidSchoolEmail(email:String) -> Bool{
        return email.hasSuffix("@bc.edu")
        //return true
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        emailTextField.resignFirstResponder()
    }
    @IBAction func doneKeyPressedforpassword(_ sender: UITextField) {
        passwordTextField.resignFirstResponder()
    }
    

    @IBAction func signInButtonPressed(_ sender: UIButton) {
        loading.isHidden = false
        loading.startAnimating()
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil && user != nil {
                //This is if the login works
                if FirebaseManager.isEmailVerified {
                FirebaseManager.isLoggedIn = true
                FirebaseManager.logInInfo = LogInInfo.init(email:email, password:password)
                self.performSegue(withIdentifier: "gotoGeneralPollVC", sender: self)
                print("Successfully logged in with info:")
                print(FirebaseManager.logInInfo ?? "")

            }
                print("login successful")
                print(Auth.auth().currentUser!)
                self.performSegue(withIdentifier: "gotoGeneralPollVC", sender:nil)
            }  else{
                    DispatchQueue.main.async {
                        //self.progress.stopAnimating()
                        self.showErrorAlert(error: FirebaseManager.returnErrorMessages(error: error!))
                        self.loading.isHidden = true                    }
                }
        }
}
    
    
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
//        guard let email = emailTextField.text else {return}
//        guard let password = passwordTextField.text else {return}
//        guard let username = usernameTextField.text else {return}
//        if isValidSchoolEmail(email: email) {
//            Auth.auth().createUser(withEmail: email, password: password) {
//                (user, error) in
//
//                Auth.auth().currentUser?.sendEmailVerification(completion: { (error:Error?) in
//                    if error == nil{
//                        print("Verification email sent!")
//                    }
//                })
//
//                if error == nil {
//                    self.performSegue(withIdentifier: "goToVerifyVC", sender:nil)
//                    FirebaseManager.isLoggedIn = true
//                    FirebaseManager.logInInfo = LogInInfo.init(email:email, password:password)
//                    FirebaseManager.logInInfo?.saved = false
//                    print("Unverified account created")
//                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//                    changeRequest?.displayName = username
//                    print("The sketchy username code executed")
//
//                }else{
//                    DispatchQueue.main.async {
//                        //self.progress.stopAnimating()
//                        self.showErrorAlert(error: FirebaseManager.returnErrorMessages(error: error!))
//                    }
//                }
//            }
//
//        }
//        else {
//            self.showErrorAlert(error: "Make sure you use a valid school email.")
//        }
        performSegue(withIdentifier: "toSignUpVC", sender: nil)
    }
//        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
//            if error != nil {
//                print(error!)
//                self.showErrorAlert(error: FirebaseManager.returnErrorMessages(error: error!))
//            } else {
////                print("registration successful")
//                self.performSegue(withIdentifier: "toVerifyVC", sender:nil)
//                FirebaseManager.isLoggedIn = true
//                FirebaseManager.logInInfo = LogInInfo.init(email:email, password:password)
//                FirebaseManager.logInInfo?.saved = false
//                print("Unverified account created")
//            }
//        }

}




