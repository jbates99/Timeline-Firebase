//
//  Post.swift
//  Timeline
//
//  Created by Joshua Bates on 6/2/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Post {
    let imageEndPoint: String
    var caption: String?
    let username: String
    var comments: [Comment]
    var likes: [Like]
    let identifier: String?
    
    init(imageEndPoint: String, caption: String?, username: String, identifier: String?, comments: [Comment] = [], likes: [Like] = []) {
        self.imageEndPoint = imageEndPoint
        self.caption = caption
        self.username = username
        self.identifier = identifier
        self.comments = comments
        self.likes = likes
    }
}