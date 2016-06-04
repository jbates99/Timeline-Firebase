//
//  UserSearchTableTableViewController.swift
//  Timeline
//
//  Created by Joshua Bates on 6/4/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class UserSearchTableTableViewController: UITableViewController {
    
    enum ViewMode: Int {
        case friends = 0
        case all = 1
        
        func users(completion: (users: [User]?) -> Void) {
            switch self {
            case .friends:
                UserController.followedByUser(UserController.sharedController.currentUser!) { (followers) -> Void in completion(users: followers)
                }
            case .all:
                UserController.fetchAllUsers() { (users) -> Void in
                    completion(users: users)
                }
            }
            
        }
    }
    
    @IBOutlet var modeSegmentedControl: UISegmentedControl!
    
    var mode: ViewMode {
        get {
            return ViewMode(rawValue: modeSegmentedControl.selectedSegmentIndex)!
        }
    }
    
    var usersDataSource = [User]()
    
    @IBAction func selectedIndexChanged(sender: AnyObject) {
        updateViewBasedOnMode()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewBasedOnMode()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateViewBasedOnMode() {
        mode.users() { (users) -> Void in
            if let users = users {
                self.usersDataSource = users
            } else {
                self.usersDataSource = []
            }
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersDataSource.count
    }
    
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
     let user = usersDataSource[indexPath.row]
     cell.textLabel?.text = user.username
     return cell
     }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
