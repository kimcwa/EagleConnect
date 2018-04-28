//
//  Majors.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/17/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import Foundation
import Firebase

class Majors {
    var majorArray = [Major]()
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("MajorPolls").addSnapshotListener { (QuerySnapshot, error) in
            guard error == nil else {
                print("ERROR: ADDING THE SNAPSHOT LISTER \(error?.localizedDescription)")
                return completed()
            }
            self.majorArray = []
            // there are querySnapshot!.documents.count documents in the spots snapshot
            for document in QuerySnapshot!.documents {
                let spot = Major(dictionary: document.data())
                spot.documentID = document.documentID
                self.majorArray.append(spot)
            }
            completed()
        }
    }
}
