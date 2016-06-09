//
//  LoginInfoViewController.swift
//  Timeline
//
//  Created by Joshua Bates on 6/8/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class LoginInfoViewController: UIViewController {
    
    enum ViewMode {
        case signup
        case login
        case edit
    }
    
    var mode: ViewMode = .signup
    var user: User?
    
    @IBOutlet var actionButton: UIButton!
    @IBOutlet var urlTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var bioTextField: UITextField!
    
    var fieldsAreValid: Bool {
        switch mode {
        case .login:
            return !(emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty)
        case .signup:
            return !(emailTextField.text!.isEmpty || usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty)
        case .edit:
            return !(usernameTextField.text!.isEmpty)
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewBasedOnMode()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionButtonTapped(sender: AnyObject) {
        
        
        if fieldsAreValid {
            switch mode {
            case .login:
                UserController.authenticateUser(emailTextField.text!, password: passwordTextField.text!, completion: { (success,user) -> Void in
                    if success, let _ = user {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidatoinAlertWithTitle("Unable to Log In", message: "Please check your information and try again")
                    }
                })
            case .signup:
                UserController.createUser(emailTextField.text!, username: usernameTextField.text!, password: passwordTextField.text!, bio: bioTextField.text, url: urlTextField.text, completion: { (success, user) -> Void in
                    if success, let _ = user {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidatoinAlertWithTitle("Unable to Signup", message: "Please check your information and try again")
                    }
                })
            case .edit:
                UserController.updateUser(self.user!, username: self.usernameTextField.text!, bio: self.bioTextField.text, url: self.urlTextField.text, completion: { (success, user) in
                    if success {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidatoinAlertWithTitle("Unable to Update User", message: "Please check your information and try again")
                    }
                })
            }
        } else {
            presentValidatoinAlertWithTitle("Missing Information", message: "Please check your information and try again")
            
        }
    }
    
    func updateViewBasedOnMode() {
        switch mode {
        case .signup:
            actionButton.setTitle("Sign Up", forState: .Normal)
        case .login:
            actionButton.setTitle("Log in", forState: .Normal)
            usernameTextField.hidden = true
            bioTextField.hidden = true
            urlTextField.hidden = true
        case .edit:
            actionButton.setTitle("Update", forState: .Normal)
            emailTextField.hidden = true
            passwordTextField.hidden = true
            
            if let user = self.user {
                usernameTextField.text = user.username
                bioTextField.text = user.bio
                urlTextField.text = user.url
            }
        }
    }
    
    func presentValidatoinAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
}




    