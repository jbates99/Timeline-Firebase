//
//  ProfileHeaderCollectionReusableViewDelegate.swift
//  Timeline
//
//  Created by Joshua Bates on 6/9/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

protocol ProfileHeaderCollectionReusableViewDelegate {
    func userTappedFollowActionButton()
    func userTappedURLButton()
}

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    
    
    var delegate: ProfileHeaderCollectionReusableViewDelegate?
    
    func updateWithUser(user: User) {
        if let bio = user.bio {
            bioLabel.text = bio
        } else {
            bioLabel.hidden = true
        }
        
        if let url = user.url {
            urlLabel.text = url
        } else {
            urlLabel.hidden = true
        }
        
        if user == UserController.sharedController.currentUser {
            followButton.setTitle("Logout", forState: .Normal)
        } else {
            UserController.userFollowsUser(UserController.sharedController.currentUser, user2: user, completion: { (follows) -> Void in
                if follows {
                    self.followButton.setTitle("Unfollow", forState: .Normal)
                } else {
                    self.followButton.setTitle("Follow", forState: .Normal)
                }
        })
        
        
    }
        
        
}