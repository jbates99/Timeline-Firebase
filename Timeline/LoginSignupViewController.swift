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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateViewBasedOnMode(){
        switch mode {
        case .signup:
            signupStackView.hidden = false
            selectionStackView.hidden = true
            actionButton.titleLabel?.text = "Sign Up"
        case .login:
            signupStackView.hidden = false
            selectionStackView.hidden = true
            actionButton.titleLabel?.text = "Log In"
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
