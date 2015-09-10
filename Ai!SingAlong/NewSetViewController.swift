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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
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
                
                if password != "" {
                    
                    setlistUpdate["password"] = password
                    
                } else {
                    
                    setlistUpdate["password"] = "none"
                    
                }
                
                callAlert("Save", message: "Save new setlist?", canCancel: true, completion: { () -> Void in
                    
                    setlistUpdate.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                        
                        if succeeded {
                            
                            println("Setlist class updated.")
                            
                            let newSet = PFObject(className: finalName)
                            
                            newSet.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                                
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









