//
//  Like.swift
//  Timeline
//
//  Created by Joshua Bates on 6/2/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Like: Equatable, FirebaseType {
    
    private let kPost = "post"
    private let kUsername = "username"
    
    let username: String
    let postIdentifier: String
    var identifier: String?
    var endpoint: String {
        return "/posts/\(self.postIdentifier)/likes/"
    }
    var jsonValue: [String: AnyObject] {
        return [kUsername: username, kPost: postIdentifier]
    }
    init(username: String, postIdentifier: String, identifier: String? = nil) {
        self.username = username
        self.postIdentifier = postIdentifier
        self.identifier = identifier
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let postIdentifier = json[kPost] as? String, let username = json[kUsername] as? String else { return nil }
        
        self.postIdentifier = postIdentifier
        self.username = username
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