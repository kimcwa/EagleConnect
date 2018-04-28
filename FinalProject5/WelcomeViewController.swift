//
//  WelcomeViewController.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/25/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    

    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser {
            self.performSegue(withIdentifier: "gotoGeneralPollVC", sender: self)
        }
        performSegue(withIdentifier: "toInitialVC", sender: nil)
        
    }


}
