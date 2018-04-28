//
//  Users.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/24/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import Foundation
import Firebase

class AppUsers {
    var userArray = [AppUser]()
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("Users").addSnapshotListener { (QuerySnapshot, error) in
            guard error == nil else {
                print("ERROR: ADDING THE SNAPSHOT LISTER \(error?.localizedDescription)")
                return completed()
            }
            self.userArray = []
            // there are querySnapshot!.documents.count documents in the spots snapshot
            for document in QuerySnapshot!.documents {
                let spot = AppUser(dictionary: document.data())
                spot.documentID = document.documentID
                self.userArray.append(spot)
            }
            completed()
        }
    }
}
