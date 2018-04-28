//
//  GeneralPolls.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/21/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import Foundation
import Firebase

class GeneralPolls {
    var generalPollArray = [GeneralPoll]()
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("GeneralPolls").addSnapshotListener { (QuerySnapshot, error) in
            guard error == nil else {
                print("ERROR: ADDING THE SNAPSHOT LISTER \(error?.localizedDescription)")
                return completed()
            }
            self.generalPollArray = []
            // there are querySnapshot!.documents.count documents in the spots snapshot
            for document in QuerySnapshot!.documents {
                let spot = GeneralPoll(dictionary: document.data())
                spot.documentID = document.documentID
                self.generalPollArray.append(spot)
            }
            completed()
        }
    }
}
