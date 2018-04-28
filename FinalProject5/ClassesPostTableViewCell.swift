//
//  ClassesPostTableViewCell.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/19/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit

class ClassesPostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var professorLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(post:Course) {
//        usernameLabel.text = post.username
        courseLabel.text = post.BCclass
        professorLabel.text = post.professor
        postLabel.text = post.post
    }

}
