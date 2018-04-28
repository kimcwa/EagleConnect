//
//  NewMajorPollVC02.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/16/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit

class NewMajorPollVC02: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var newMajorSelectionLabel: UILabel!
    
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var whatOnYourMindLabel: UILabel!
    
    var NewMajorSelection: String!
    var major: Major!

    override func viewDidLoad() {
        super.viewDidLoad()
        postTextView.resignFirstResponder()
        postTextView.delegate = self
        newMajorSelectionLabel.text = NewMajorSelection
//        postTextView.text = "What would you like to ask about \(NewMajorSelection)?"
        major = Major()
    }
    
//    func leaveViewController() {
//        let isPresentingInAddMode = presentingViewController is UINavigationController
//        if isPresentingInAddMode {
//            dismiss(animated: true, completion: nil)
//        } else {
//            navigationController?.popViewController(animated: true)
//        }
//    }
    
//    @IBAction func cancelButtonPressed(_ sender: UIButton) {
//        let isPresentingInAddMode = presentingViewController is UINavigationController
//        if isPresentingInAddMode {
//            dismiss(animated: true, completion: nil)
//        } else {
//            navigationController?.popViewController(animated: true)
//        }
//    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//        postTextView.text = ""
        whatOnYourMindLabel.text = ""
        return true
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        major.post = postTextView.text!
        major.major = NewMajorSelection
        // NEED ONE FORE USERNAME
        
        major.saveData {
            success in
            if success {
                self.performSegue(withIdentifier: "unwindToMajorPollVC", sender: nil)
            } else {
                print("*** ERROR; COULDNT LEAVE THIS VIEW CONTROLLER BECAUSE DATA WASNT SAVED")
            }
        }
    }
    
    
    

//    @IBAction func saveButtonPressed(_ sender: UIButton) {
//        major.post = postTextOutlet.text!
//        major.major = NewMajorSelection
//        // NEED ONE FORE USERNAME
//
//        major.saveData {
//            success in
//            if success {
//                self.performSegue(withIdentifier: "toMajorPollVC", sender: nil)
//            } else {
//                print("*** ERROR; COULDNT LEAVE THIS VIEW CONTROLLER BECAUSE DATA WASNT SAVED")
//            }
//        }
//    }
    

}
