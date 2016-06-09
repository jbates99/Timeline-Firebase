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
    
    static func followUser(user: User, completion: (success: Bool) -> Void) {
        
    }
    
    static func unfollowUser(user: User, completion: (success: Bool) -> Void) {
        
    }
    
    static func userFollowsUser(user: User, user2: User, completion: (follows: Bool) -> Void) {
        
    }
    
    static func followedByUser(user: User, completion: (followed: [User]?) -> Void) {
        
    }
    
    static func authenticateUser(email: String, password: String, completion: (success: Bool, user: User?) -> Void) {
        completion(success: false, user: nil)
    }
    
    static func createUser(email: String, username: String, password: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        
    }
    
    static func updateUser(user: User, username: String, bio: String?, url: String?, completion: (success: Bool, user:User?) -> Void) {
        
    }
    
    static func logOutCurrentUser() {
        
    }
    
    static func mockUsers() -> [User] {
        return [User.init(username: "Josh", identifier: "1"), User.init(username: "Ivette", identifier: "2"), User.init(username: "Jakob", identifier: nil)]
    }
    
}
