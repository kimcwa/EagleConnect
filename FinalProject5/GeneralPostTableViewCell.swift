//
//  GeneralPostTableViewCell.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/22/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit

class GeneralPostTableViewCell: UITableViewCell {

    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
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
    
    func set(post:GeneralPoll) {
//        usernameLabel.text = post.username
        subjectLabel.text = post.subject
        postLabel.text = post.post
    }

}
