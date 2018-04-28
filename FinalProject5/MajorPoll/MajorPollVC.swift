//
//  MajorPollVC.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/7/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit

class MajorPollVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var majorLabel: UILabel!
    
    var majorSelection1: String!
    
    var majorPosts: Majors!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        majorLabel.text = majorSelection1
        
        majorPosts = Majors()
        
        print(majorSelection1)
        
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        majorPosts.loadData {
            self.tableView.reloadData()
        }
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tabBarController?.navigationController?.show(self, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMajorDetailVC" {
            let destination = segue.destination as! MajorPollDetailVC
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.major = majorPosts.majorArray[selectedIndexPath.row]
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    
    @IBAction func unwindFromNewGeneralPoll(segue: UIStoryboardSegue) {
        print(">>>> I successfully segued!")
    }
    
    
}


extension MajorPollVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return majorPosts.majorArray.count 
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "majorCell", for: indexPath) as! PostTableViewCell
        cell.layer.cornerRadius = cell.frame.height / 2
//        cell.layer.cornerRadius = cell.frame.height / 2  THIS MAKES THE CELLS ROUNDED KINDA UGLY THOUGH...
        
//        cell.usernameLabel.text = majorPosts.majorArray[indexPath.row].username
//        cell.majorLabel.text = majorPosts.majorArray[indexPath.row].major
//        cell.postTextLabel.text = majorPosts.majorArray[indexPath.row].post
        cell.set(post: majorPosts.majorArray[indexPath.row])
//        cell.documentID = majorPosts.majorArray[indexPath.row].documentID // documentID for like/unlike function
//        for person in majorPosts.majorArray[indexPath.row].peopleWhoLike {
//            if person == Auth.auth().currentUser!.uid {
//                cell.likeBtn.isHidden = true
//                cell.unlikeBtn.isHidden = false
//                break
//            }
//        }
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//
//    }
}











