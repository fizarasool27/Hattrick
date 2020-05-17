//
//  ViewController.swift
//  Flash Chat
//
//  Created by Fiza Rasool on 02/05/19.
//  Copyright © 2019 Fiza Rasool. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var messageArray : [Message] = [Message]()
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        messageTextfield.delegate = self
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        messageTableView.register(UINib(nibName : "MessageCell", bundle : nil) , forCellReuseIdentifier: "customMessageCell")
        
        configureTableview()
        retreiveMessages()
        
        messageTableView.separatorStyle = .none
        
    }
    
    //MARK: - TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        
        
        if cell.senderUsername.text == Auth.auth().currentUser?.email as String! {
            //messages we sent
            
            cell.avatarImageView.backgroundColor = UIColor.flatPink
            cell.messageBody.backgroundColor = UIColor.flatMint
            cell.avatarImageView.image = UIImage(named: "IMG_7705")
        }
            
        else {
            
            cell.avatarImageView.backgroundColor = UIColor.flatPowderBlue
            cell.messageBackground.backgroundColor = UIColor.flatGray
            cell.avatarImageView.image = UIImage(named: "anyUser")
        }
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messageArray.count
    }
    
    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
    }
    
    func configureTableview() {
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    
    //MARK:- TextField Delegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        UIView.animate(withDuration: 1) {
            self.heightConstraint.constant = 308.0
            self.view.layoutIfNeeded()
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 1) {
            self.heightConstraint.constant = 50.0
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    //MARK: - Send & Recieve from Firebase
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextfield.endEditing(true)
        
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        let messagesDB = Database.database().reference().child("Messages")
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email,"MessageBody": messageTextfield.text!]
        
        messagesDB.childByAutoId().setValue(messageDictionary) {
            (error,reference) in
            if error != nil {
                print(error)
            }
            else {
                print("Message saved successfully!")
            }
            
            self.messageTextfield.isEnabled = true
            self.sendButton.isEnabled = true
            self.messageTextfield.text = ""
        }
    }
    
    func retreiveMessages() {
        
        let messageDB = Database.database().reference().child("Messages")
        
        messageDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            
            let message = Message()
            message.sender = sender
            message.messageBody = text
            
            self.messageArray.append(message)
            
            self.configureTableview()
            self.messageTableView.reloadData()
            
        }
    }
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
            
        catch {
            print("Error, there was a problem signing out.")
        }
        
    }
    
    
    
}
