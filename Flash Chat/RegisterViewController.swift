//
//  RegisterViewController.swift
//  Flash Chat
//
//  Created by Fiza Rasool on 04/05/19.
//  Copyright © 2019 Fiza Rasool. All rights reserved.
//  This is the View Controller which registers new users with Firebase
//

import UIKit
import Firebase
import SVProgressHUD


class RegisterViewController: UIViewController {

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

  
    @IBAction func registerPressed(_ sender: AnyObject) {
        
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) {
            (user, error) in
            
            if error != nil {
                print("The error is : \(String(describing: error))")
            }
                else {
                    print("Registration Successful!")
                
                    SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: "goToTab", sender: self)
                }
            }
        }
        
        
    } 
    
    

