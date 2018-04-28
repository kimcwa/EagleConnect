//
//  NewMajorPollVC.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/7/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit

class NewMajorPollVC: UIViewController {
    
    
    
    @IBOutlet weak var majorTextField: UITextField!
    

    
    
    let majorsArray = ["Select Major", "Art History", "American Heritage", "Applied Psychology and Human Development", "Accounting", "Biology", "Business Analytics", "Chemistry", "Classical Studies", "Communication",   "Computer Science", "Corporate Reporting and Analysis", "Corporate Systems", "Criminal and Social Justice", "Economics", "English", "Environmental Geosciences", "Environmental Studies", "Elementary Education", "Entrepreneurship", "Film Studies", "Finance", "French", "Geological Sciences", "German Studies", "General Science", "General Management", "Hispanic Studies", "History", "International Studies", "Islamic Civilization and Societies", "Italian", "Information Systems", "Information Systems and Accounting", "Linguistics", "Mathematics", "Music", "Management and Leadership", "Managing for Social Impact and the Public Good", "Marketing", "Nursing", "Natural Science", "Operations Management", "Philosophy", "Physics", "Political Science", "Psychology", "Perspectives on Spanish America", "Romance Languages and Literatures", "Russian", "Slavic Studies", "Sociology", "Studio Art", "Secondary Education", "Social Sciences", "Theater", "Theology"
    ]
    
    var selectedMajor: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LOADED IN!!!")
        createMajorPicker()
        createToolbar()
    }
    
    
    func createMajorPicker() {
        let majorPicker = UIPickerView()
        majorPicker.delegate = self
        
        majorTextField.inputView = majorPicker
    }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(NewMajorPollVC.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        majorTextField.inputAccessoryView = toolBar
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {// pass major selected to next VC
        let navVC = segue.destination as! UINavigationController
        let destination = navVC.viewControllers.first as! NewMajorPollVC02
        print("*****" + selectedMajor)
        destination.NewMajorSelection = selectedMajor
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        if majorTextField.text != nil {
            print(selectedMajor)
            performSegue(withIdentifier: "toMajorPollVC02", sender: nil)
        } else {
            print("There was nothing in this text field so can't go back to MajorPoll")
        }
    }
    
    
}

extension NewMajorPollVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return majorsArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return majorsArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMajor = majorsArray[row]
        majorTextField.text = selectedMajor
    }
}

