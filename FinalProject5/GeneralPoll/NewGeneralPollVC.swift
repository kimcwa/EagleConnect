//
//  NewGeneralPollVC.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/21/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit

class NewGeneralPollVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var whatsHappeningLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var generalPoll: GeneralPoll!
    
    let subjectArray = ["Select Subject", "Clubs/Events", "Dining", "Occupation", "Promotions", "Research Query", "Other"]
    var selectedSubject: String = ""
    
//    var filteredSubjectArray = [String]()
//    HAVE AN ARRAY OF SUBJECT TO CHOOSE FROM AND DO ANOTHER AUTOCOMPLETE THING
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTextView.resignFirstResponder()
//        postTextView.text = "What's on Your mind?"
//        doneButton.backgroundColor = UIColor.red
        doneButton.layer.cornerRadius = doneButton.bounds.height / 2
        doneButton.clipsToBounds = true
        
        postTextView.delegate = self
        generalPoll = GeneralPoll()
        
        createSubjectPicker()
        createToolbar()
        
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
//        toolbar.setItems([doneButton], animated: true)
//        postTextView.inputAccessoryView = toolbar
    }
    
//    @objc func doneClicked() {
//        view.endEditing(true)
//    }

    
    @IBAction func doneKeyPressedforsubject(_ sender: UITextField) {
        subjectTextField.resignFirstResponder()
    }
    

    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//        postTextView.text = ""
        whatsHappeningLabel.text = ""
        return true
    }

    
//    func filterSearchResults() {
//        self.filteredSubjectArray = self.subjectArray.filter { (subject: String) -> Bool
//            in if (subject.lowercased().range(of: subjectTextField.text!.lowercased()) != nil) {
//                return true
//            } else {
//                return false
//            }
//        }
//    }
    
    func createSubjectPicker() {
        let subjectPicker = UIPickerView()
        subjectPicker.delegate = self
        
        subjectTextField.inputView = subjectPicker
    }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(NewGeneralPollVC.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        subjectTextField.inputAccessoryView = toolBar
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        generalPoll.post = postTextView.text!
        generalPoll.subject = subjectTextField.text!
        // one for username
        generalPoll.saveData {
            success in
            if success {
                self.performSegue(withIdentifier: "unwindToGeneralPollVC", sender: nil)
            } else {
                print("*** ERROR; COULDNT LEAVE THIS VIEW CONTROLLER BECAUSE DATA WASNT SAVED")
            }
        }
    }
    
    
    
    

}

extension NewGeneralPollVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subjectArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subjectArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSubject = subjectArray[row]
        subjectTextField.text = selectedSubject
    }
}

