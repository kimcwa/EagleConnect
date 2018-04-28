//
//  GeneralPostTableViewCell2.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/24/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit

class GeneralPostTableViewCell2: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    var generalPoll: GeneralPoll!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
