//
//  User.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/24/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//
import Foundation
import Firebase

// I HAVE NOT CURRENTLY IMPLEMENTED THIS YET

class AppUser {
    var email: String
    var displayName: String
    var userSince: Date
    var documentID: String

    var dictionary: [String: Any] {
        return ["email": email, "displayName": displayName, "userSince": userSince]
    }

    init(email: String, displayName: String, userSince: Date, documentID: String) {
        self.email = email
        self.displayName = displayName
        self.userSince = userSince
        self.documentID = documentID
    }

    convenience init(dictionary: [String: Any]) {
        let email = dictionary["email"] as! String? ?? ""
        let displayName = dictionary["displayName"] as! String? ?? ""
        let userSince = dictionary["userSince"] as! Date? ?? Date()
        let documentID = Auth.auth().currentUser?.uid ?? ""
        self.init(email: email, displayName: displayName, userSince: userSince, documentID: documentID)
    }

    convenience init (user: User) {
        self.init(email: user.email!, displayName: user.displayName!, userSince: Date(), documentID: user.uid)
    }

    convenience init (userID: String) {
        // initializes an empty AppUser, which can then be used to call .getUserData()
        self.init(email: "", displayName: "", userSince: Date(), documentID: userID)
    }

    func loadUser(completed: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        let userRef = db.collection("Users").document("\(documentID)")
        userRef.getDocument { (document, error) in
            guard error == nil else {
                print("*** ERROR: in User accessing document for user \(userRef) \(error!.localizedDescription)")
                return completed(false)
            }
            guard let dictionary = document?.data() else {
                print("*** NO DATA: User did not return data for user \(self.documentID)")
                return completed(false)
            }
            self.email = dictionary["email"] as! String? ?? ""
            self.displayName = dictionary["displayName"] as! String? ?? ""
            self.userSince = dictionary["userSince"] as! Date? ?? Date()
            completed(true)
        }
    }

    func saveIfNewUser() {
        let db = Firestore.firestore()
        let userRef = db.collection("Users").document("\(documentID)")
        userRef.getDocument { (document, error) in
            guard error == nil else {
                print("error in accessing document for user \(userRef) \(error!.localizedDescription)")
                return
            }
            guard document?.exists == false else {
                print("Document exists for user \(self.documentID)")
                return
            }
            // No errors, but no document, so create new user document
            self.saveData()
        }
    }

    func saveData()  {
        let db = Firestore.firestore()
        // Create the dictionary representing data we want to save
        let dataToSave: [String: Any] = self.dictionary
        db.collection("Users").document(documentID).setData(dataToSave) { (error) in
            if let error = error {
                print("ERROR: adding user \(error.localizedDescription) with userID \(self.documentID)")
            }
        }
    }
}

