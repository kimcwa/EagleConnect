//
//  PostTableViewCell.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/7/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit
import Firebase

class PostTableViewCell: UITableViewCell {
    


    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likesButton: UIButton!
    @IBOutlet weak var unlikeButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    var documentID: String!
    
   
    override func awakeFromNib() {
//        super.awakeFromNib()
//
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
//        profileImage.clipsToBounds = true
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
    func set(post:Major) {
//        usernameLabel.text = post.username
        postTextLabel.text = post.post
        majorLabel.text = post.major
    }
    
//    @IBAction func likePressed(_ sender: UIButton) {
//        let ref = Database.database().reference()
//        let keyToPost = ref.child("MajorPolls").childByAutoId().key
//        ref.child("MajorPolls").child(self.documentID).observeSingleEvent(of: .value, with:  {
//            (snapshot) in
//            if let majorPoll = snapshot.value as? [String:AnyObject] {
//                let updateLikes: [String : Any] = ["peopleWhoLike/\(keyToPost)" : Auth.auth().currentUser!.uid]
//                ref.child("MajorPolls").child(self.documentID).updateChildValues(updateLikes, withCompletionBlock: { (error, reff) in
//
//                    if error == nil {
//                        ref.child("MajorPolls").child(self.documentID).observeSingleEvent(of: .value, with: { (snap) in
//                            if let properties = snap.value as? [String : AnyObject] {
//                                if let likes = properties["peopleWhoLike"] as? [String : AnyObject] {
//                                    let count = likes.count
//                                    self.likesLabel.text = "\(count) Likes"
//
//                                    let update = ["likes" : count]
//                                    ref.child("MajorPolls").child(self.documentID).updateChildValues(update)
//
//                                    self.likesButton.isHidden = true
//                                    self.unlikeButton.isHidden = false
//                                    self.likesButton.isEnabled = true
//                                }
//                            }
//                        })
//                    }
//                })
//            }
//        })
//        ref.removeAllObservers()
//    }
//
//
//    @IBAction func unlikeButtonPressed(_ sender: UIButton) {
//        self.unlikeButton.isEnabled = false
//        let ref = Database.database().reference()
//
//
//        ref.child("MajorPolls").child(self.documentID).observeSingleEvent(of: .value, with: { (snapshot) in
//
//            if let properties = snapshot.value as? [String : AnyObject] {
//                if let peopleWhoLike = properties["peopleWhoLike"] as? [String : AnyObject] {
//                    for (id,person) in peopleWhoLike {
//                        if person as? String == Auth.auth().currentUser!.uid {
//                            ref.child("MajorPolls").child(self.documentID).child("peopleWhoLike").child(id).removeValue(completionBlock: { (error, reff) in
//                                if error == nil {
//                                    ref.child("MajorPolls").child(self.documentID).observeSingleEvent(of: .value, with: { (snap) in
//                                        if let prop = snap.value as? [String : AnyObject] {
//                                            if let likes = prop["peopleWhoLike"] as? [String : AnyObject] {
//                                                let count = likes.count
//                                                self.likesLabel.text = "\(count) Likes"
//                                                ref.child("MajorPolls").child(self.documentID).updateChildValues(["likes" : count])
//                                            }else {
//                                                self.likesLabel.text = "0 Likes"
//                                                ref.child("MajorPolls").child(self.documentID).updateChildValues(["likes" : 0])
//                                            }
//                                        }
//                                    })
//                                }
//                            })
//
//                            self.likesButton.isHidden = false
//                            self.unlikeButton.isHidden = true
//                            self.unlikeButton.isEnabled = true
//                            break
//
//                        }
//                    }
//                }
//            }
//
//        })
//        ref.removeAllObservers()
//    }
    
    
    
    
    
    
    
    
}
