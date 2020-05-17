//
//  LogInViewController.swift
//  Flash Chat
//
//  Created by Fiza Rasool on 03/05/19.
//  Copyright © 2019 Fiza Rasool. All rights reserved.


import UIKit
import Firebase
import SVProgressHUD


class LogInViewController: UIViewController {

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    @IBAction func logInPressed(_ sender: AnyObject) {
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            
            if error != nil {
                print(error!)
            }
            else {
                print("Log in was successful!")
                
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "goToTab", sender: self)
                
            
            }
            
        }
        
    }
    
}  
