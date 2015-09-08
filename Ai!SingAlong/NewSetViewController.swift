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
        
        println("Create Button pressed.")
        
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
                    
                }
                
                setlistUpdate.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                    
                    if succeeded {
                        
                        println("Setlist class updated.")
                        
                        let newSet = PFObject(className: finalName)
                        newSet["name"] = setName
                        
                        newSet.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                            
                            if succeeded {
                                
                                println("New set class created.")
                                
                                let setlistMenuVC = self.storyboard?.instantiateViewControllerWithIdentifier("setlistMenuVC") as! SetlistMenuViewController
                                
                                setlistMenuVC.setToLoad = finalName
                                
                                self.navigationController?.pushViewController(setlistMenuVC, animated: true)
                                
                            } else {
                                
                                println("Something just went haywire.")
                                
                            }
                            
                        })
                        
                    } else {
                        
                        println("Something just went haywire.")
                        
                    }
                    
                })
                
            } else {
                
                let errorAlert = UIAlertController(title: "Error", message: "Passwords don't match.", preferredStyle: UIAlertControllerStyle.Alert)
                
                let confirmAction = UIAlertAction(title: "OK", style: .Default) { (action: UIAlertAction!) -> Void in
                    
                }
                
                errorAlert.addAction(confirmAction)
                
                self.presentViewController(errorAlert, animated: true, completion: nil)
                
            }
            
        } else {
            
            let errorAlert = UIAlertController(title: "Error", message: "Please enter a name for your setlist.", preferredStyle: UIAlertControllerStyle.Alert)
            
            let confirmAction = UIAlertAction(title: "OK", style: .Default) { (action: UIAlertAction!) -> Void in
                
            }
            
            errorAlert.addAction(confirmAction)
            
            self.presentViewController(errorAlert, animated: true, completion: nil)
            
        }
        
    }

    @IBAction func backButtonPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }

}









