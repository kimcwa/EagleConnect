//
//  GeneralPollVC.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/21/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit

class GeneralPollVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var generalPolls: GeneralPolls!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        generalPolls = GeneralPolls()
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        generalPolls.loadData {
            self.tableView.reloadData()
        }
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tabBarController?.navigationController?.show(self, sender: nil)
    }

    @IBAction func addGeneralPollButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toNewGeneralPollVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGeneralPollDetailVC" {
            let destination = segue.destination as! GeneralPollDetailVC
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.generalPoll = generalPolls.generalPollArray[selectedIndexPath.row]
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    
    @IBAction func commentButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toGeneralPollCommentVC", sender: nil)
    }
    
    @IBAction func unwindFromNewGeneralPollITSREALGENERALPOLL(segue: UIStoryboardSegue) {
       
    }
    

}

extension GeneralPollVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return generalPolls.generalPollArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "generalPollCell", for: indexPath) as! GeneralPostTableViewCell
//        THIS MAKES THE CELLS ROUNDED KINDA UGLY THOUGH...
//        cell.layer.cornerRadius = cell.frame.height / 2
//        cell.usernameLabel.text = generalPolls.generalPollArray[indexPath.row].username
//        cell.postLabel.text = generalPolls.generalPollArray[indexPath.row].post
        cell.set(post: generalPolls.generalPollArray[indexPath.row])
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
}
