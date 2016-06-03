//
//  Like.swift
//  Timeline
//
//  Created by Joshua Bates on 6/2/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Like: Equatable {
    let username: String
    let postIdentifier: String
    let identifier: String?
    
    init(username: String, postIdentifier: String, identifier: String? = nil) {
        self.username = username
        self.postIdentifier = postIdentifier
        self.identifier = identifier
    }
}

func ==(lhs: Like, rhs: Like) -> Bool {
    if lhs.username == rhs.username && lhs.identifier == rhs.identifier {
        return true
    } else {
        return false
    }
}