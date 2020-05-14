//
//  NewClassPollVC02.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/23/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit

class NewClassPollVC02: UIViewController {

    @IBOutlet weak var professorTextField: UITextField!
    @IBOutlet weak var courseLabel: UILabel!

    let professorArray = ["Select Area","Boston", "Newton","Chestnut Hill", "Allston", "Boston College", "Boston University","Tufts University","MIT","Harvard", "Other shit"]
    
    var selectedProfessor: String = ""
    var courseSelection: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseLabel.text = courseSelection
        createProfessorPicker()
        createToolbar()
    }
    
    func createProfessorPicker() {
        let professorPicker = UIPickerView()
        professorPicker.delegate = self
        professorTextField.inputView = professorPicker
    }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(NewClassPollVC02.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        professorTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewClassPollVC02" {
            let navVc = segue.destination as! UINavigationController
            let destination = navVc.viewControllers.first as! NewClassPollVCFinal
            destination.professorSelection = selectedProfessor
        }
        else {
            let navVc = segue.destination as! UINavigationController
            let destination = navVc.viewControllers.first as! NewClassPollVCFinal
            destination.courseSelection = courseSelection
            let navVC = segue.destination as! UINavigationController
            let destination2 = navVC.viewControllers.first as! NewClassPollVCFinal
            destination2.professorSelection = selectedProfessor
        }
    }
    
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toNewClassPollFInalVC", sender: nil)
    }
    

}

extension NewClassPollVC02: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return professorArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return professorArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedProfessor = professorArray[row]
        professorTextField.text = selectedProfessor
    }
}



