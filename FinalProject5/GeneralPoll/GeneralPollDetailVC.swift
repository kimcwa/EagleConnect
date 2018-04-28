//
//  GeneralPollDetailVC.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/22/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit

class GeneralPollDetailVC: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    var generalPoll: GeneralPoll!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if generalPoll == nil {
            generalPoll = GeneralPoll()
        }
//        usernameLabel.text = generalPoll.username
        subjectLabel.text = generalPoll.subject
        postLabel.text = generalPoll.post
    }
    
    
    @IBAction func replyButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toReplyToGeneralPollVC", sender: nil)
    }
    
    

}
