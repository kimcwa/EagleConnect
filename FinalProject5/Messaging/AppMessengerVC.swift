//
//  AppMessengerVC.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/24/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit
import Firebase
//import JSQMessagesViewController


class AppMessengerVC: UIViewController  {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMessageDetailVC" {
            let destination = segue.destination as! MessagingDetailVC
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            //            destination.generalPoll = generalPolls.generalPollArray[selectedIndexPath.row]
            //        } else {
            //            if let selectedIndexPath = tableView.indexPathForSelectedRow {
            //                tableView.deselectRow(at: selectedIndexPath, animated: true)
            //            }
            //        }
        }
        
    }
    
}

extension AppMessengerVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        cell.textLabel?.text = "You have nobody in your chat yet!"
        return cell
    }
}

