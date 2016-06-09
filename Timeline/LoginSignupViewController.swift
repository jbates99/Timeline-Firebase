//
//  LoginSignupViewController.swift
//  Timeline
//
//  Created by Joshua Bates on 6/2/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit


class LoginSignupViewController: UIViewController {

    enum ViewMode {
        case signup
        case login
        case edit
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("loginSelected", sender: nil)
        
    }
    @IBAction func signUpButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("signupSelected", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let loginViewController = segue.destinationViewController as? LoginInfoViewController else { fatalError("unexpected destination from segue") }
        if segue.identifier == "loginSelected" {
            loginViewController.mode = .login
            } else if segue.identifier == "signupSelected" {
            loginViewController.mode = .signup
        }
    }

}
