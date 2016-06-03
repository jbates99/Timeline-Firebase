//
//  User.swift
//  Timeline
//
//  Created by Joshua Bates on 6/2/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct User: Equatable {
    let username: String
    var bio: String?
    let url: String?
    let identifier: String?
    
    init(username: String, bio: String? = nil, url: String? = nil, identifier: String?) {
        self.username = username
        self.identifier = identifier
        self.bio = bio
        self.url = url
    }
}

func ==(lhs: User, rhs:User) -> Bool {
    if lhs.username == rhs.username && lhs.identifier == rhs.identifier {
        return true
    } else {
        return false
    }
}