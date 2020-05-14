//
//  CommentCell.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/25/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit
import Firebase

class CommentCell: UITableViewCell {
    

    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var professorLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    var courseLabelS = ""
    var professorLabelS = ""
    var postLabelS = ""
    
    var course: Course!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        courseLabel.text = courseLabelS
        professorLabel.text = professorLabelS
        postLabel.text = postLabelS
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
