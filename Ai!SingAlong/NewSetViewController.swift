//
//  NewSetViewController.swift
//  Ai!SingAlong
//
//  Created by Kyle Brooks Robinson on 9/8/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit
import Parse
import Bolts

class NewSetViewController: UIViewController {

    @IBOutlet weak var setlistName: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillChangeFrameNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            self.view.setNeedsUpdateConstraints()
            self.view.setNeedsLayout()
            
            if let kbSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size{
                
                self.bottomConstraint.constant = 20 + kbSize.height
                
            }
            
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidHideNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            self.bottomConstraint.constant = 20

        // Do any additional setup after loading the view.
        }
        
    }
    
    func createDate() -> String {
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let date = NSDate()
        
        let dateString = formatter.stringFromDate(date)
        println("Date String! \(dateString)")
        
        return dateString
        
    }
    
    @IBAction func createButtonPressed(sender: AnyObject) {
        
        if setlistName.text != "" {
            
            if passwordField.text == confirmPassword.text {
                
                let setName = setlistName.text
                let setNumber = arc4random_uniform(100000)
                let finalName = "\(setName)_\(setNumber)"
                let password = passwordField.text
                
                let setlistUpdate: PFObject = PFObject(className: "setlist")
                setlistUpdate["identifier"] = finalName
                setlistUpdate["name"] = setName
                setlistUpdate["date"] = createDate()
                
                if password != "" {
                    
                    setlistUpdate["password"] = password
                    
                } else {
                    
                    setlistUpdate["password"] = "none"
                    
                }
                
                let newClass: PFObject = PFObject(className: finalName)
                newClass["songName"] = "Song name"
                newClass["artistName"] = "Artist name"
                newClass["albumName"] = "Album name"
                newClass["albumYear"] = 2015
                newClass["numberOfBlocks"] = 4
                newClass["firstBlock"] = "First block"
                newClass["secondBlock"] = "Second block"
                newClass["thirdBlock"] = "Third block"
                newClass["fourthBlock"] = "Fourth block"
                
                
                callAlert("Save", message: "Save new setlist?", canCancel: true, completion: { () -> Void in
                    
                    
                    setlistUpdate.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                        
                        if succeeded {
                            
                            println("Setlist class updated.")
                            
                            newClass.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                                
                                if succeeded {
                                    
                                    self.dismissViewControllerAnimated(true, completion: nil)
                                    
                                } else {
                                    
                                    println("Something just went haywire.")
                                    
                                }
                                
                            })
                            
                        } else {
                            
                            println("Something just went haywire.")
                            
                        }
                        
                    })
                    
                    
                })
                
            } else {
                
                callAlert("Error", message: "Passwords don't match.", canCancel: false, completion: nil)
                
            }
            
        } else {
        
            callAlert("Error", message: "Please enter a name for your setlist.", canCancel: false, completion: nil)
            
        
        }
        
    }
    
    func callAlert(title: String, message: String, canCancel: Bool, completion: (() -> Void)?) {
        
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let confirmAction = UIAlertAction(title: "OK", style: .Default) { (action: UIAlertAction!) -> Void in
            
            if completion != nil {
                
                completion!()
                
            }
            
        }
        
        myAlert.addAction(confirmAction)
        
        if canCancel == true {
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction!) -> Void in
                
            }
            
            myAlert.addAction(cancelAction)
            
        }
        
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }

}









