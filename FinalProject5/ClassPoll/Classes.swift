//
//  Classes.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/19/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import Foundation
import Firebase

class Courses {
    var courseArray = [Course]()
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("ClassPolls").addSnapshotListener { (QuerySnapshot, error) in
            guard error == nil else {
                print("ERROR: ADDING THE SNAPSHOT LISTER \(error?.localizedDescription)")
                return completed()
            }
            self.courseArray = []
            // there are querySnapshot!.documents.count documents in the spots snapshot
            for document in QuerySnapshot!.documents {
                let spot = Course(dictionary: document.data())
                spot.documentID = document.documentID
                self.courseArray.append(spot)
            }
            completed()
        }
    }
}
