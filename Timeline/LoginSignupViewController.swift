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
    }
    var mode: ViewMode = .signup
    
    
    // MARK: IBOutlets
    
    @IBOutlet var selectionStackView: UIStackView!
    @IBOutlet var signupStackView: UIStackView!
    @IBOutlet var actionButton: UIButton!
    @IBOutlet var urlTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var bioTextField: UITextField!
    
    var fieldsAreValid: Bool {
        switch mode {
        case .signup:
            if !usernameTextField.text!.isEmpty && !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty {
                return true
            } else { return false }
            
        case .login:
            if !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty {
                return true
            } else { return false }
            
        }
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
        mode = .login
        updateViewBasedOnMode()
    }
    @IBAction func signUpButtonPressed(sender: AnyObject) {
        mode = .signup
        updateViewBasedOnMode()
    }
    func updateViewBasedOnMode(){
        switch mode {
        case .signup:
            signupStackView.hidden = false
            selectionStackView.hidden = true
            actionButton.setTitle("Sign Up", forState: .Normal)
        case .login:
            signupStackView.hidden = false
            selectionStackView.hidden = true
            actionButton.setTitle("Log in", forState: .Normal)
            usernameTextField.hidden = true
            bioTextField.hidden = true
            urlTextField.hidden = true
        }
    }
    
    
    @IBAction func actionButtonTapped(sender: AnyObject) {
        let alertController = UIAlertController(title: "Try Again", message: nil, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alertController.addAction(okAction)
        
        guard fieldsAreValid else { return }
        switch mode {
        case .login:
            UserController.authenticateUser(emailTextField.text!, password: passwordTextField.text!, completion: { (user) -> Bool in
                if user != nil {
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                    return true
                } else {
                    self.presentViewController(alertController, animated: true, completion: nil)
                    return false }
            })
        case .signup:
            UserController.createUser(emailTextField.text!, username: usernameTextField.text!, password: passwordTextField.text!, bio: nil, completion: { (user) -> Bool in
                if user != nil {
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                    return true
                } else {
                    self.presentViewController(alertController, animated: true, completion: nil)
                    return false }
            })
            
        }
        
    }

}
