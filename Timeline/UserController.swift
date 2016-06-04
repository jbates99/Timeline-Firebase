//
//  UserController.swift
//  Timeline
//
//  Created by Joshua Bates on 6/2/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class UserController {
    var currentUser: User? = nil
    
    static let sharedController = UserController()
    
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {

    }
    
    static func fetchAllUsers(completion: (users: [User]) -> Void) {
        
    }
    
    static func followUser(user: User, completion: () -> Bool) {
        
    }
    
    static func unfollowUser(user: User, completion: () -> Bool) {
        
    }
    
    static func userFollowsUser(user: User, user2: User, completion: () -> Bool) {
        
    }
    
    static func followedByUser(user: User, completion: (followed: [User]?) -> Void) {
        
    }
    
    static func authenticateUser(email: String, password: String, completion: (user: User?) -> Bool) {
        completion(user: nil)
    }
    
    static func createUser(email: String, username: String, password: String, bio: String?, completion: (User?) -> Bool) {
        
    }
    
    static func updateUser(user: User, username: String, bio: String?, completion: (User?) -> Bool) {
        
    }
    
    static func logOutCurrentUser() {
        
    }
    
    static func mockUsers() -> [User] {
        return [User.init(username: "Josh", identifier: "1"), User.init(username: "Ivette", identifier: "2"), User.init(username: "Jakob", identifier: nil)]
    }
    
}