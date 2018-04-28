//
//  FirebaseManager.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/5/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

// this saves the login information and set to user defaults
struct LogInInfo {
    var email: String
    var password: String
    var saved: Bool
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
        self.saved = true
    }
    
    init(dictionary:[String:String]?) {
        
        if dictionary == nil {
            self.email = ""
            self.password = ""
            self.saved = false
            
            return
        }
        
        self.email = dictionary!["email"]!
        self.password = dictionary!["password"]!
        self.saved = true
    }
    
    var dictionary: [String:String] {
        return ["email":self.email, "password":self.password]
    }

}

class FirebaseManager {
        static var isEmailVerified = false
        
        static func initialSetup() {
            Auth.auth().addStateDidChangeListener({ (auth:Auth, user:User?) in
                // if user is linked and verified
                if let user = user, user.isEmailVerified {
                    self.isEmailVerified = true
                    print("User is verified")
                } else {
                    print("User is not verified")
                }
            })
        }
    
    
    // store login info for auto-login
    
    static var logInInfo: LogInInfo? {
        set {
            UserDefaults.standard.set(newValue?.dictionary, forKey: "logInInfoKey")
        }
        get {
            return LogInInfo.init(dictionary: UserDefaults.standard.dictionary(forKey: "logInInfoKey") as? [String:String])
        }
        
    }
    
    // is user logged in
    static var isLoggedIn = false
    
    //log out with auto log in
    static func logout() {
        print("Logging Out")
        let user = Auth.auth().currentUser
        self.logInInfo?.saved = false
        self.logInInfo = nil
        self.isLoggedIn = false
        try! Auth.auth().signOut()
        
//        DataHandler.clearDataHandler()
//        DataHandler.clearDefaults()
        
        // deleting the account if it is not verified
        if user?.isEmailVerified == false {
            user?.delete {
                error in
                if let _ = error {
                    print("Error deleting user")
                } else {
                    print("Unverified user successfully deleted")
                }
            }
        }
        print(FirebaseManager.logInInfo ?? "No login info saved")
    }
    
    static func deleteUnverfifiedUserAccount() {
        // delete the account if its not verified
        let user = Auth.auth().currentUser
        if user?.isEmailVerified == false {
            FirebaseManager.logInInfo?.saved = false
            user?.delete { error in
                if let _ = error {
                    print("Error deleting user")
                } else {
                    print("Unverified user successfully deleted")
                }
            }
        }
    }
    
    static func deleteUser() {
        // delete an account
        let user = Auth.auth().currentUser
        FirebaseManager.logInInfo?.saved = false
        user?.delete { error in
            if let _ = error {
                print("Error deleting user")
            } else {
                print("User successfully deleted")
            }
        }
        //deleting form database
        let ref = Database.database().reference()
        let userReference = ref.child("user").child((user?.uid)!)
        userReference.removeValue()
    }
    
    // DONT HAVE PASSWORD RESET YET
    
    
    static func returnErrorMessages(error:Error) -> String {
        guard let firebaseError = error as NSError? else {
            return ""
        }
        if let errorCode = AuthErrorCode(rawValue:firebaseError.code) {
            switch errorCode {
            case .userNotFound:
                return "The account linked to this email address could not be found"
            case .wrongPassword:
                return "Password does not match your email address"
            case .userDisabled:
                return "You're account address is not longer valid. Contact Us for more Info"
            //Registration error
            case .invalidEmail:
                return "Make sure your email address is valid"
            case .weakPassword:
                return "Your password must be at least 6 characters"
            case .emailAlreadyInUse:
                return "This email address is already registered"
            case .accountExistsWithDifferentCredential:
                return "Account exists with different credentials"
            default:
                return "Error. Contact Us"
            
            }
            
            
        }
        return ""
    }
    
    
    
}
    
    
    
    

