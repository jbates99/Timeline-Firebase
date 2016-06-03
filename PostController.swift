//
//  PostController.swift
//  Timeline
//
//  Created by Joshua Bates on 6/2/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import Foundation

class PostController {
    
    static func fetchTimelineForUser(user: User, completion: (post: Post) -> Bool) {
        
    }
    
    static func addPost(image: UIImage, caption: String?, completion: (Post?) -> Bool) {
        
    }
    
    static func postFromIdentifier(identifier: String, completion: (Post?) -> Void) {
        
    }
    
    static func postsForUser(user: User, completion: ([Post]?) -> Void) {
        
    }
    
    static func deletePost(post: Post) {
        
    }
    
    static func addCommentWithTextToPost(text: String, post: Post, completion: (Post?) -> Bool) {
        
    }
    
    static func deleteComment(comment: Comment, completion: (Post?) -> Bool) {
        
    }
    
    static func addLikeToPost(post: Post, completion: (Post?) -> Bool) {
        
    }
    
    static func deleteLike(like: Like, completion: (Post?) -> Bool) {
        
    }
    
    static func orderPosts(posts: [Post]) -> [Post] {
        return []
    }
    
    static func mockPosts() -> [Post] {
        let imageString = "-K1l4125TYvKMc7rcp5e"
        return [Post(imageEndPoint: imageString, caption: nil, username: "Me", identifier: nil)]
    }
}