//
//  PostTableViewCell.swift
//  Timeline
//
//  Created by Joshua Bates on 6/10/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    

    func updateWithPost(post: Post) {
        self.postImageView.image = nil
        self.likesLabel.text = "\(post.likes.count) likes"
        self.commentsLabel.text = "\(post.comments.count) comments"
        ImageController.imageForIdentifier(post.endpoint) { (image) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.postImageView.image = image
            })
        }
    }
    
}
