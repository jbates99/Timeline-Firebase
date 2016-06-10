//
//  Post.swift
//  Timeline
//
//  Created by Joshua Bates on 6/2/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Post: Equatable, FirebaseType {
    
    private let kUsername = "username"
    private let kImageEndpoint = "image"
    private let kCaption = "caption"
    private let kComments = "comments"
    private let kLikes = "likes"
    
    let imageEndPoint: String
    let caption: String?
    let username: String
    let comments: [Comment]
    let likes: [Like]
    var identifier: String?
    var endpoint: String {
        return "posts"
    }
    var jsonValue: [String : AnyObject] {
        var json: [String: AnyObject] = [kUsername : username, kImageEndpoint : imageEndPoint, kComments : comments.map({$0.jsonValue}), kLikes : likes.map({$0.jsonValue})]
        
        if let caption = caption {
            json.updateValue(caption, forKey: kCaption)
        }
        
        return json
    }
    
    init(imageEndPoint: String, caption: String?, username: String, identifier: String?, comments: [Comment] = [], likes: [Like] = []) {
        self.imageEndPoint = imageEndPoint
        self.caption = caption
        self.username = username
        self.identifier = identifier
        self.comments = comments
        self.likes = likes
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let imageEndPoint = json[kImageEndpoint] as? String, let username = json[kUsername] as? String else { return nil }
        
        self.imageEndPoint = imageEndPoint
        self.caption = json[kCaption] as? String
        self.username = username
        self.identifier = identifier
        
        if let commentDictionaries = json[kComments] as? [String : AnyObject] {
            self.comments = commentDictionaries.flatMap({Comment(json: $0.1 as! [String : AnyObject], identifier: $0.0)})
        } else {
            self.comments = []
    }
        if let likesDictionaries = json[kLikes] as? [String : AnyObject] {
            self.likes = likesDictionaries.flatMap({Like(json: $0.1 as! [String : AnyObject], identifier: $0.0)})
        } else {
            self.likes = []
        }

}
}
func ==(lhs: Post, rhs: Post) -> Bool {
    
    return (lhs.username == rhs.username) && (lhs.identifier == rhs.identifier)
}