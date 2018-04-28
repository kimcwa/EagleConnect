//
//  NewClassPollVCFinal.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/23/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit

class NewClassPollVCFinal: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var professorLabel: UILabel!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var whatOnYourMindLabel: UILabel!
    
    var course: Course!
    
    var courseSelection: String = ""
    var professorSelection: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        postTextView.delegate = self
        postTextView.resignFirstResponder()
//        postTextView.text = "What's on Your Mind?"
        courseLabel.text = courseSelection
        professorLabel.text = professorSelection
        
        course = Course()
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//        postTextView.text = ""
        whatOnYourMindLabel.text = ""
        return true
    }

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
//        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "toClassPollVC", sender: nil)

    }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        course.post = postTextView.text
        course.BCclass = courseSelection
        course.professor = professorSelection
        // NEED ONE FORE USERNAME

        
        course.saveData {
            success in
            if success {
                self.performSegue(withIdentifier: "UnwindToClassPollVC", sender: nil)
            } else {
                print("*** ERROR; COULDNT LEAVE THIS VIEW CONTROLLER BECAUSE DATA WASNT SAVED")
            }
        }
    }
    
    

}
