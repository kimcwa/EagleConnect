//
//  ClassPollVC.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/5/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit
import Firebase

class ClassPollVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var classPosts: Courses!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    self.navigationItem.setHidesBackButton(true, animated: false)
        classPosts = Courses()
//        classPosts.courseArray.append(Course(username: "BK", userID: "something", BCclass: "Swift Programming", professor: "Gallaugher", post: "Stay Swifty", documentID: "something"))
//        classPosts.courseArray.append(Course(username: "BK", userID: "something", BCclass: "Multivariable", professor: "Ellen Goldstein", post: "Clairut's Theorem", documentID: "something"))
        
//        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        classPosts.loadData {
            self.tableView.reloadData()
        }
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
//        self.tabBarController?.navigationController?.show(self, sender: nil)
//        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }
    
    @IBAction func unwindFromNewClassPollFinal(segue: UIStoryboardSegue) {
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toClassDetailVC" {
            let destination = segue.destination as! ClassPollDetailVC
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.course = classPosts.courseArray[selectedIndexPath.row]
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    
    


}

extension ClassPollVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classPosts.courseArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! ClassesPostTableViewCell
//        cell.layer.cornerRadius = cell.frame.height / 2
//        cell.usernameLabel.text = classPosts.courseArray[indexPath.row].username!
//        cell.courseLabel.text = classPosts.courseArray[indexPath.row].BCclass
//        cell.professorLabel.text = classPosts.courseArray[indexPath.row].professor
//        cell.postLabel.text = classPosts.courseArray[indexPath.row].post
        cell.set(post: classPosts.courseArray[indexPath.row])
        return cell
    }
}
