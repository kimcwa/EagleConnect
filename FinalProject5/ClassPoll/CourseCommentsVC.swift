//
//  CourseCommentsVC.swift
//  FinalProject5
//
//  Created by Bryan Kim on 5/15/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit

class CourseCommentsVC: UIViewController {
//
//    @IBOutlet weak var courseLabel: UILabel!
//    @IBOutlet weak var professorLabel: UILabel!
//    @IBOutlet weak var postLabel: UILabel!
    
    var classSelection: Courses!
    
    @IBOutlet weak var tableView: UITableView!
    var commentsArray = [Comment]() // Comment
    var selectedCourse: Course! // Comment
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        classSelection = Courses()
        
//        if selectedCourse == nil {
//            selectedCourse = Course()
//        }
        
      
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        classSelection.loadData {
            self.tableView.reloadData()
        }
    }

    

  

}

extension CourseCommentsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        cell.set(post: classSelection.courseArray[indexPath.row])
        return cell
    }
}


