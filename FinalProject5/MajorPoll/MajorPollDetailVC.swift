//
//  MajorPollDetailVC.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/19/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit

class MajorPollDetailVC: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    
    var major: Major!

    override func viewDidLoad() {
        super.viewDidLoad()

        if major == nil {
            major = Major()
        }
//        usernameLabel.text = major.username
        majorLabel.text = major.major
        postLabel.text = major.post
    }

  

}
