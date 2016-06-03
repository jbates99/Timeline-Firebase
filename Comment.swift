//
//  Comment.swift
//  Timeline
//
//  Created by Joshua Bates on 6/2/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Comment: Equatable {
    let username: String
    var text: String
    let postIdentifier: String
    let identifier: String?
    
    init(username: String, text: String, postIdentifier: String, identifier: String? = nil) {
        self.username = username
        self.text = text
        self.postIdentifier = postIdentifier
        self.identifier = identifier
    }
}

func ==(lhs: Comment, rhs: Comment) -> Bool {
    if lhs.username == rhs.username && lhs.postIdentifier == rhs.postIdentifier {
        return true
    } else {
        return false
    }
}