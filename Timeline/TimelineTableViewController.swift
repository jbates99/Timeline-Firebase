//
//  TimelineTableViewController.swift
//  Timeline
//
//  Created by Joshua Bates on 5/31/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class TimelineTableViewController: UITableViewController {
    
    var postsForUser = [Post]()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        if let currentUser = UserController.sharedController.currentUser {
            PostController.postsForUser(currentUser, completion: { (posts: [Post]?) in
                guard let posts = posts else { return }
                self.postsForUser = posts
            })
        } else {
            self.performSegueWithIdentifier("loginSegue", sender: nil)
        }
        
    }
    
    func loadTimelineForUser (user: User) {
        PostController.fetchTimelineForUser(user) { (posts) -> Void in
            if let posts = posts {
                self.postsForUser = posts
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                })
            } else {
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postsForUser.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TimelineCell", forIndexPath: indexPath) as! PostTableViewCell
        
        let post = postsForUser[indexPath.row]
        
        cell.updateWithPost(post)
        
        
        return cell
    }
    // MARK: - ADD REFRESHING ACTION HERE
    // userRefreshedTable() {
    // loadTimelineForUser(UserController.sharedController.currentUser)
    //  }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "timelineToPostDetail" {
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPathForCell(cell) {
                let post = postsForUser[indexPath.row]
                let destinationViewController = segue.destinationViewController as? PostDetailTableViewController
                destinationViewController?.post = post
            }
        }
    }
    
}
