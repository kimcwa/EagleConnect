//
//  GeneralPoll.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/21/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import Foundation
import Firebase

class GeneralPoll {
    var username: String!
    var userID: String!
//    var BCclass: String!
//    var professor: String!
    var post: String!
    var subject: String!
    var documentID: String!
    
    var generalPollDictionary: [String: Any] {
        return ["userID": userID, "username": username, "post": post, "subject": subject]
    }
    
    init(username: String, userID: String, post: String, subject: String, documentID: String) {
        self.username = username
        self.userID = userID
        self.post = post
        self.subject = subject
        self.documentID = documentID
    }
    
    
    convenience init() {
        self.init(username: "", userID: "", post: "", subject: "", documentID: "")
    }
    
    
    convenience init(dictionary: [String :Any]) {
        let username = dictionary["username"] as! String? ?? ""
        let post = dictionary["post"] as! String? ?? ""
        let subject = dictionary["subject"] as! String? ?? ""
        let userID = dictionary["postingUserID"] as! String? ?? ""
        self.init(username: username, userID: userID, post: post, subject: subject, documentID: "")
    }
    
    func saveData(completed: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        //grab the userID
        guard let userID = (Auth.auth().currentUser?.uid) else {
            print("*** ERROR: COULD NOT SAVE DATA BECAUSE WE DONT HAVE A VALID postingUSERID")
            return completed(false)
        }
        self.userID = userID
        // Create the dictionary representing the data we want save
        let dataToSave = self.generalPollDictionary
        //if we HAVE saved a record, we'll have a documentID
        if self.documentID != "" {
            let ref = db.collection("GeneralPolls").document(self.documentID)
            ref.setData(dataToSave) {
                (error) in if let error = error {
                    print("****** ERROR: updating document \(self.documentID) \(error.localizedDescription)")
                    completed(false)
                }
                else {
                    print("^^^ Document updated with ref ID \(ref.documentID)")
                    completed(true)
                }
            }
        } else {
            var ref: DocumentReference? = nil // let firestore create the new documentID
            ref = db.collection("GeneralPolls").addDocument(data: dataToSave) { error in
                if let error = error {
                    print("****** ERROR: updating document \(self.documentID) \(error.localizedDescription)")
                    completed(false)
                } else {
                    print("^^^ Document updated with ref ID \(ref?.documentID ?? "unknown")")
                    completed(true)
                }
            }
        }
    }
}


