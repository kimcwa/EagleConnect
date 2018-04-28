//
//  DataHandler.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/11/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import Foundation
import Firebase

class DataHandler {
    static var user = Auth.auth().currentUser
    static var uid = Auth.auth().currentUser?.uid
    static var databaseRef = Database.database().reference()
    static var storageRef = Storage.storage().reference()
    
    //Update the user's email in Firebase.
//    static func updateEmail(email:String) {
//        updateUserData(uid: uid!, values: ["Email": email])
//    }
}
