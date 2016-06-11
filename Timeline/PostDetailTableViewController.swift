//
//  PostDetailTableViewController.swift
//  Timeline
//
//  Created by Joshua Bates on 5/31/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {
    
    var post: Post?
    //likesLabel
    //commentLabel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBasedOnPost()
    }
    
    func updateBasedOnPost() {
        //        guard let post = post else { return }
        //        self.likesLabel.text = "\(post.likes.count) likes"
        //        self.commentsLabel.text = "\(post.comments.count) comments"
        //
        //        ImageController.imageForIdentifier(post.imageEndPoint) { (image) -> Void in
        //            self.headerImageView.image = image
        //        }
        //        tableView.reloadData()
    }
    
    
    func likeTapped() {
        
        PostController.addLikeToPost(post!) { (success, post) -> Void in
            if let post = post {
                self.post = post
                self.updateBasedOnPost()
            }
        }
    }
    
    func addCommentTapped() {
        let commentAlert = UIAlertController(title: "Add Comment", message: nil, preferredStyle: .Alert)
        commentAlert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Comment"
        }
        commentAlert.addAction(UIAlertAction(title: "Add Comment", style: .Default, handler: { (action) -> Void in
            if let text = commentAlert.textFields?.first?.text {
                PostController.addCommentWithTextToPost(text, post: self.post!, completion: { (success, post) -> Void in
                    if let post = post {
                        self.post = post
                        self.updateBasedOnPost()
                    }
                })
            }
        }))
        commentAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        presentViewController(commentAlert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return post!.comments.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath)
        
        let comment = post?.comments[indexPath.row]
        
        if let comment = comment {
            cell.textLabel?.text = comment.username
            cell.detailTextLabel?.text = comment.text
        }
        
        return cell
    }
    
}
