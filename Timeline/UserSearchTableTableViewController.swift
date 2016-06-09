//
//  UserSearchTableTableViewController.swift
//  Timeline
//
//  Created by Joshua Bates on 6/4/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class UserSearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
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
    
    var usersDataSource = [User]()
    var searchController: UISearchController!
    var mode: ViewMode {
        get {
            return ViewMode(rawValue: modeSegmentedControl.selectedSegmentIndex)!
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewBasedOnMode()
        setUpSearchController()
        
    }
    
    @IBAction func selectedIndexChanged(sender: AnyObject) {
        updateViewBasedOnMode()
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
    
    func setUpSearchController() {
        let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ResultsScene")
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchTerm = searchController.searchBar.text!.lowercaseString
        let resultsViewController = searchController.searchResultsController as! UserSearchResultsTableViewController
        
        resultsViewController.userResultsDataSource = usersDataSource.filter( { $0.username.lowercaseString.containsString(searchTerm) } )
        resultsViewController.tableView.reloadData()
        
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "searchToProfile" {
            guard let cell = sender as? UITableViewCell else { return }
            
            if let indexPath = tableView.indexPathForCell(cell) {
                let user = usersDataSource[indexPath.row]
                let destinationViewController = segue.destinationViewController as? ProfileViewController
                destinationViewController?.user = user
                
            } else if let indexPath = (searchController.searchResultsController as? UserSearchResultsTableViewController)?.tableView.indexPathForCell(cell) {
                let user = (searchController.searchResultsController as! UserSearchResultsTableViewController).userResultsDataSource[indexPath.row]
                let destinationViewController = segue.destinationViewController as? ProfileViewController
                destinationViewController?.user = user
            }
        }
    }
}
