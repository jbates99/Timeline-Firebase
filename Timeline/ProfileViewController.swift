//
//  ProfileViewController.swift
//  Timeline
//
//  Created by Joshua Bates on 6/2/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import SafariServices

class ProfileViewController: UIViewController {
    
    var user: User?
    var userPosts: [Post] = []
    
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if user == nil {
            user = UserController.sharedController.currentUser
            // editBarButtonItem.enabled = true
        }
        updateBasedOnUser()
    }
    
    func updateBasedOnUser() {
        guard let user = user else { return }
        title = user.username
        
        PostController.postsForUser(user) { (posts) -> Void in
            if let posts = posts {
                self.userPosts = posts
            } else {
                self.userPosts = []
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.collectionView.reloadData()
            })
        }
    }
    
    func logoutButtonTapped() {
        
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editUser" {
            let destinationViewController = segue.destinationViewController as? LoginSignupViewController
            _ = destinationViewController?.view
            //destinationViewController?.updateWithUser(user!)
        } else if segue.identifier == "profileToPostDetail" {
            if let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPathForCell(cell) {
                let post = userPosts[indexPath.item]
                let destinationViewController = segue.destinationViewController as? PostDetailTableViewController
                destinationViewController?.post = post
            }
        }
    }
    
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        let post = userPosts[indexPath.item]
        cell.updateWithImageIdentifier(post.imageEndPoint)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView", forIndexPath: indexPath) as! ProfileHeaderCollectionReusableView
        headerView.updateWithUser(user!)
        headerView.delegate = self
        
        return headerView
    }
    
}

extension ProfileViewController: ProfileHeaderCollectionReusableViewDelegate {
    
    func urlButtonPressed() {
        if let profileURL = NSURL(string: user!.url!) {
            let safariViewController = SFSafariViewController(URL: profileURL)
            presentViewController(safariViewController, animated: true, completion: nil)
        }
    }
    
    func followButtonPressed() {
        guard let user = user else { return }
        if user == UserController.sharedController.currentUser {
            UserController.logOutCurrentUser()
            tabBarController?.selectedViewController = tabBarController?.viewControllers![0]
        } else {
            UserController.userFollowsUser(UserController.sharedController.currentUser!, user2: user) { (follows) -> Void in
                if follows {
                    UserController.unfollowUser(self.user!, completion: { (success) -> Void in
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.updateBasedOnUser()
                        })
                    })
                } else {
                    UserController.followUser(self.user!, completion: { (succss) -> Void in
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.updateBasedOnUser()
                        })
                    })
                }
            }
        }
    }
}
