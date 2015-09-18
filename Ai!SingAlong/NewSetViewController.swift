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

protocol MakeNewSetDelegate {
    
    func didFinishMakingSet(set: PFObject)
    
}

class NewSetViewController: UIViewController {

    @IBOutlet weak var setlistName: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var delegate: MakeNewSetDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillChangeFrameNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            self.view.setNeedsUpdateConstraints()
            self.view.setNeedsLayout()
            
            if let kbSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size{
                
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
        print("Date String! \(dateString)")
        
        return dateString
        
    }
    
    @IBAction func createButtonPressed(sender: AnyObject) {
        
        if setlistName.text != "" {
            
            if passwordField.text == confirmPassword.text {
                
                let name = setlistName.text!
                let password = passwordField.text
                
                // Updating the Parse setlist collection with the new setlist.
                let setlistUpdate: PFObject = PFObject(className: "setlist")
                setlistUpdate["name"] = name
                setlistUpdate["date"] = createDate()
                
                if password != "" {
                    
                    setlistUpdate["password"] = password
                    
                } else {
                    
                    setlistUpdate["password"] = "none"
                    
                }
                
                setlistUpdate["songInfo"] = [
                
                    [
                        "songName":"Song Name",
                        "artistName":"Artist Name",
                        "albumName":"Album Name",
                        "albumYear":2015,
                        "blocks": [
                        
                            [
                                "title": "Block name",
                                "contents":"Block lyrics go here."
                            ]
                        
                        ],
                    
                    ]

                ]
                
                callAlert("Save", message: "Save new setlist?", canCancel: true, completion: { () -> Void in
                    
                    setlistUpdate.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                        
                        if succeeded {
                            
                            print("Setlist class updated.")
                            
                            self.delegate?.didFinishMakingSet(setlistUpdate)
                            
                            self.navigationController?.popViewControllerAnimated(true)
                            
                        } else {
                            
                            print("Something just went haywire.")
                            
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
        
        let confirmAction = UIAlertAction(title: "OK", style: .Default) { (action: UIAlertAction) -> Void in
            
            if completion != nil {
                
                completion!()
                
            }
            
        }
        
        myAlert.addAction(confirmAction)
        
        if canCancel == true {
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction) -> Void in
                
            }
            
            myAlert.addAction(cancelAction)
            
        }
        
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }

}









