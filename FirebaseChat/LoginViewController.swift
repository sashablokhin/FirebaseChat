//
//  ViewController.swift
//  FirebaseChat
//
//  Created by Alexander Blokhin on 25.02.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    private let myRootRef = Firebase(url:"https://simple-chatapp.firebaseio.com")

    @IBAction func loginButtonPressed(sender: AnyObject) {
        myRootRef.authUser(emailTextField.text, password: passwordTextField.text,
            withCompletionBlock: { (error, auth) in
                if error != nil {
                    print(error.userInfo["NSLocalizedDescription"]!)
                }
        })
    }
    
    @IBAction func signUpButtonPressed(sender: AnyObject) {
        let alert = UIAlertController(title: "Register",
            message: "Register",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default) { (action: UIAlertAction!) -> Void in
                
                let emailField = alert.textFields![0]
                let passwordField = alert.textFields![1]
                
                self.myRootRef.createUser(emailField.text, password: passwordField.text) { (error: NSError!) in
                    if error == nil {
                        self.myRootRef.authUser(emailField.text, password: passwordField.text,
                            withCompletionBlock: { (error, auth) -> Void in
                        })
                    }
                }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textEmail) -> Void in
            textEmail.placeholder = "Enter your email"
            textEmail.keyboardType = .EmailAddress
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textPassword) -> Void in
            textPassword.secureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        myRootRef.observeAuthEventWithBlock { (authData) -> Void in
            if authData != nil {
                self.performSegueWithIdentifier("showMessages", sender: authData)
            }
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMessages" {
            
            let nav = segue.destinationViewController as! UINavigationController
            
            let vc = nav.viewControllers[0] as! MessagesViewController 
            vc.user = sender as! FAuthData?
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

