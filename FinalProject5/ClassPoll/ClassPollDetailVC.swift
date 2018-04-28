//
//  ClassPollDetailVC.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/19/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit

class ClassPollDetailVC: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var professorLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    
    var course: Course!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if course == nil {
            course = Course()
        }
//        usernameLabel.text = course.username
        courseLabel.text = course.BCclass
        professorLabel.text = course.professor
        postLabel.text = course.post
    }
    
    @IBAction func replyButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toReplyToClassPollVC", sender: nil)
    }
    
    
}
