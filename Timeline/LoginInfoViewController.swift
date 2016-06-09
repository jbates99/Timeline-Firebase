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
    }
    
    var mode: ViewMode = .signup
    
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
        updateViewBasedOnMode()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func updateViewBasedOnMode(){
        switch mode {
        case .signup:
            actionButton.setTitle("Sign Up", forState: .Normal)
        case .login:
            actionButton.setTitle("Log in", forState: .Normal)
            usernameTextField.hidden = true
            bioTextField.hidden = true
            urlTextField.hidden = true
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
