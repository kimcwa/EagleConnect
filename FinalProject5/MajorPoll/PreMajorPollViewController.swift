//
//  PreMajorPollViewController.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/23/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import Foundation
import UIKit

class PreMajorPollViewController: UIViewController, SecondDropDownProtocol {
    
    
    var button = dropDownBtn()
    
    var selectedMajor: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //Configure the button
        button = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.setTitle("Select Major", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        //Add Button to the View Controller
        self.view.addSubview(button)
        
        //button Constraints
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 305).isActive = true
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        //Set the drop down menu's options
        button.delegate = self
        button.dropView.dropDownOptions = ["Art History", "American Heritage", "Applied Psychology/Human Dev", "Accounting", "Biology", "Business Analytics", "Chemistry", "Classical Studies", "Communication",   "Computer Science", "Corporate Reporting and Analysis", "Corporate Systems", "Criminal and Social Justice", "Economics", "English", "Environmental Geosciences", "Environmental Studies", "Elementary Education", "Entrepreneurship", "Film Studies", "Finance", "French", "Geological Sciences", "German Studies", "General Science", "General Management", "Hispanic Studies", "History", "International Studies", "Islamic Civil. and Soc.", "Italian", "Information Systems", "Information Systems and Accounting", "Linguistics", "Mathematics", "Music", "Management and Leadership", "Managing for Social Impact/Public Good", "Marketing", "Nursing", "Natural Science", "Operations Management", "Philosophy", "Physics", "Political Science", "Psychology", "Perspectives on Spanish America", "Romance Languages/Literatures", "Russian", "Slavic Studies", "Sociology", "Studio Art", "Secondary Education", "Social Sciences", "Theater", "Theology"
        ]
        
    }
    
    
    @IBAction func addMajorPollButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toNewMajorPollVC", sender: nil)
    }
    
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toMajorPollViewController", sender: nil)
    }
    
    func dropDownPressed(string: String) {
        self.selectedMajor = string
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMajorPollViewController" {
//            let navVC = segue.destination as! UINavigationController
            let destination = segue.destination as! MajorPollVC
            destination.majorSelection1 = selectedMajor
        }
        
    }

}

protocol dropDownProtocol {
    func dropDownPressed(string : String)
}

protocol SecondDropDownProtocol {
    func dropDownPressed(string: String)
}

class dropDownBtn: UIButton, dropDownProtocol {
    
    func dropDownPressed(string: String) {
        self.setTitle(string, for: .normal)
        self.dismissDropDown()
        self.delegate?.dropDownPressed(string: string)
    }
    
    var dropView = dropDownView()
    var delegate: SecondDropDownProtocol?
    
    var height = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.darkGray
        
        dropView = dropDownView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        dropView.delegate = self
        dropView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func didMoveToSuperview() {
        self.superview?.addSubview(dropView)
        self.superview?.bringSubview(toFront: dropView)
        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false {
            
            isOpen = true
            
            NSLayoutConstraint.deactivate([self.height])
            
            if self.dropView.tableView.contentSize.height > 200 {
                self.height.constant = 200
            } else {
                self.height.constant = self.dropView.tableView.contentSize.height
            }
            
            
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height / 2
            }, completion: nil)
            
        } else {
            isOpen = false
            
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.dropView.layoutIfNeeded()
            }, completion: nil)
            
        }
    }
    
    func dismissDropDown() {
        isOpen = false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}

class dropDownView: UIView, UITableViewDelegate, UITableViewDataSource  {
    
    var dropDownOptions = [String]()
    
    var tableView = UITableView()
    
    var delegate: dropDownProtocol!
    
    var majorSelection: String! = " "
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.backgroundColor = UIColor.darkGray
        self.backgroundColor = UIColor.darkGray
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MajorPollVC
        destination.majorSelection1 = majorSelection
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dropDownOptions[indexPath.row]
//        majorSelection = dropDownOptions[indexPath.row]
        //        majorSelect.init(majorSelection1: dropDownOptions[indexPath.row])
        cell.backgroundColor = UIColor.darkGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.dropDownPressed(string: dropDownOptions[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
        majorSelection = dropDownOptions[indexPath.row]
        print(majorSelection)
    }
    
    
    
}
