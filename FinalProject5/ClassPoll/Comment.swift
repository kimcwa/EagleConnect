//
//  Comment.swift
//  FinalProject5
//
//  Created by Bryan Kim on 5/15/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import Foundation
import Firebase

class Comment {
    var username: String!
    var userID: String!
    var BCclass: String!
    var professor: String!
    var post: String!
    var documentID: String!
    

    
    var majorDictionary: [String: Any] {
        return ["userID": userID, "username": username, "BCclass": BCclass, "professor": professor, "post": post]
    }
    
    init(username: String, userID: String, BCclass: String, professor: String, post: String, documentID: String) {
        self.username = username
        self.userID = userID
        self.BCclass = BCclass
        self.professor = professor
        self.post = post
        self.documentID = documentID
    }
    
    
    convenience init() {
        self.init(username: "", userID: "", BCclass: "", professor: "", post: "", documentID: "")
    }
    
    
    convenience init(dictionary: [String :Any]) {
        let username = dictionary["username"] as! String? ?? ""
        let BCclass = dictionary["BCclass"] as! String? ?? ""
        let professor = dictionary["professor"] as! String? ?? ""
        let post = dictionary["post"] as! String? ?? ""
        let userID = dictionary["postingUserID"] as! String? ?? ""
        self.init(username: username, userID: userID, BCclass: BCclass, professor: professor, post: post, documentID: "")
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
        let dataToSave = self.majorDictionary
        //if we HAVE saved a record, we'll have a documentID
        if self.documentID != "" {
            let ref = db.collection("ClassPolls").document(self.documentID)
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
            ref = db.collection("ClassPolls").addDocument(data: dataToSave) { error in
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
