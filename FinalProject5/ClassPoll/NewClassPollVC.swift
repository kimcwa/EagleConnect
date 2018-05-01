//
//  NewClassPollVC.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/5/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit

class NewClassPollVC: UIViewController {
    
    @IBOutlet weak var courseTextField: UITextField!
    @IBOutlet weak var professorTextField: UITextField!
    
    
    let courseArray = ["Select Course", "Analysis I", "Analysis II","Artificial Intelligence", "Calculus II", "Calculus II (Math/Science Majors)","Combinatorics", "Computer Science I", "Computer Science II", "Computer Organization with Lab","Econometrics","Data Mining", "Database Systems and Applications", "Dilemmas of Unity and Diversity in American Politics and Society","Experiments in Physics I", "Food, Power, &Politics", "Functions and Differential Calculus", "Functions, Differential Calculus II", "Finite Probability and Applications", "Fundamentals of Political Science", "General Chemistry", "Globalization", "Global Implications of Climate Change","The History and Politics of Terrorism", "How to Rule the World: Intro to Political Theory", "Introduction to American Politics", "Introductory Physics", "Introduction to Abstract Mathematics","Introduction to Modern Politics","Intro to Modern Physics", "Linear Algebra","Intro to Condensed Matter Physics", "Logic and Computation","Machine Learning", "Macro Principles", "Micro Principles","Microeconomic Theory", "Macrooeconomic Theory", "Microeconomic Theory - Honors", "Macrooeconomic Theory - Honors","Mechanics", "Multivariable Calculus", "Number Theory","Optics and Lasers", "Philosphy of the Person","Physics of Nanomaterials", "Quantum Physics I", "Quantum Physics I", "Robotics", "Statistics (Economics)","Special and General Relativity","Statistical Mechanics and Thermodynamics", "Special Topics: Swift","Topology", "Waves and Vibrations"]
    
    
    var selectedCourse: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        createCoursePicker()
        createToolbar()
    }
    
    // GET A LIST OF ALL THE PROFESSORS AND COURSES AT BC. THE DATABASE STUFF WHERE I NEED MR. SALVITTI's INFORMATION COMES LATER WHEN THE USER PICKS A SPECIFIC COURSE AND/OR PROFESSOR FROM THIS LIST. 

    func createCoursePicker() {
        let coursePicker = UIPickerView()
        coursePicker.delegate = self
        courseTextField.inputView = coursePicker
    }

    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(NewClassPollVC.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        courseTextField.inputAccessoryView = toolBar
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toNewClassPollVC02", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {// pass major selected to next VC
        let destination = segue.destination as! NewClassPollVC02
        destination.courseSelection = selectedCourse
//        let destin = segue.destination as! NewClassPollVC02
//        destin.testingText = "sef"
    }
    

}

extension NewClassPollVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return courseArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return courseArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCourse = courseArray[row]
        courseTextField.text = selectedCourse
    }
}


