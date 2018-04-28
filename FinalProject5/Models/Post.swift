//
//  Post.swift
//  FinalProject5
//
//  Created by Bryan Kim on 4/7/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import Foundation

class Post {
    var id: String
    var author: String
    var text: String
    
    init(id:String, author: String, text: String) {
        self.id = id
        self.author = author
        self.text = text
    }
}
