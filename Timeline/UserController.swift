//
//  UserController.swift
//  Timeline
//
//  Created by Joshua Bates on 6/2/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import Firebase

class UserController {
    
    private let kUser = "userKey"
    
    var currentUser: User! {
        get {
            guard let uid = FIRAuth.auth()?.currentUser?.uid, let userDicionary = NSUserDefaults.standardUserDefaults().valueForKey(kUser) as? [String: AnyObject] else {
                return nil
            }
            
            return User(json: userDicionary, identifier: uid)
        }
        set {
            if let newValue = newValue {
                NSUserDefaults.standardUserDefaults().setValue(newValue.jsonValue, forKey: kUser)
                NSUserDefaults.standardUserDefaults().synchronize()
            } else {
                NSUserDefaults.standardUserDefaults().removeObjectForKey(kUser)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }
    
    static let sharedController = UserController()
    
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        FirebaseController.dataAtEndpoint("users/\(identifier)") { (data) -> Void in
            if let json = data as? [String: AnyObject] {
                let user = User(json: json, identifier: identifier)
                completion(user: user)
            } else {
                completion(user: nil)
            }
        }
    }
    
    static func fetchAllUsers(completion: (users: [User]) -> Void) {
        FirebaseController.dataAtEndpoint("users") { (data) -> Void in
            if let json = data as? [String: AnyObject] {
                let users = json.flatMap({User(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
                completion(users: users)
            } else {
                completion(users: [])
            }
        }
    }
    
    static func followUser(user: User, completion: (success: Bool) -> Void) {
        FirebaseController.base.child("/users/\(sharedController.currentUser.identifier!)/follows/\(user.identifier!)").setValue(true)
        completion(success: true)
    }
    
    static func unfollowUser(user: User, completion: (success: Bool) -> Void) {
        FirebaseController.base.child("/users/\(sharedController.currentUser.identifier!)/follows/\(user.identifier!)").removeValue()
        completion(success: true)
    }
    
    static func userFollowsUser(user: User, user2: User, completion: (follows: Bool) -> Void) {
        FirebaseController.dataAtEndpoint("/users/\(user.identifier!)/follows/\(user2.identifier!)") { (data) -> Void in
            if let _ = data {
                completion(follows: true)
            } else {
                completion(follows: false)
            }
            
        }
        
    }
    
    static func followedByUser(user: User, completion: (followed: [User]?) -> Void) {
        FirebaseController.dataAtEndpoint("/users/\(user.identifier!)/") { (data) -> Void in
            if let json = data as? [String: AnyObject] {
                var users: [User] = []
                for userJson in json {
                    userForIdentifier(userJson.0, completion: { (user) -> Void in
                        if let user = user {
                            users.append(user)
                            completion(followed: users)
                        }
                    })
                }
            } else {
                completion(followed: [])
            }
        }
    }
    
    static func authenticateUser(email: String, password: String, completion: (success: Bool, user: User?) -> Void) {
        FIRAuth.auth()?.signInWithEmail(email, password: password) { (user, error) in
            if error != nil {
                print("Unsuccessful login attempt.")
                completion(success: false, user: nil)
            } else {
                guard let uid = user?.uid else { return }
                print("User ID: \(uid) authenticated successfully.")
                UserController.userForIdentifier((uid), completion: { (user) -> Void in
                    if let user = user {
                        sharedController.currentUser = user
                    }
                    completion(success: true, user: user)
                })
            }
        }
    }
    
    static func createUser(email: String, username: String, password: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (response, error) -> Void in
            if let uid = response["uid"] as? String {
                var user = User(username: username, uid: uid, bio: bio, url: url, identifier: uid)
                user.save()
                authenticateUser(email, password: password, completion: { (success, user) -> Void in
                    completion(success: success, user: user)
                })
            } else {
                completion(success: false, user: nil)
            }
        })
    }
    
    static func updateUser(user: User, username: String, bio: String?, url: String?, completion: (success: Bool, user:User?) -> Void) {
        var updatedUser = User(username: user.username, uid: user.identifier!, bio: bio, url: url, identifier: user.identifier!)
        updatedUser.save()
        
        UserController.userForIdentifier(user.identifier!) { (user) -> Void in
            if let user = user {
                sharedController.currentUser = user
                completion(success: true, user: user)
            } else {
                completion(success: false, user: nil)
            }
        }
    }
    
    static func logOutCurrentUser() {
        try! FIRAuth.auth()!.signOut()
        UserController.sharedController.currentUser = nil
    }
    
}
