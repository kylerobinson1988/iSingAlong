//
//  SongInfoViewController.swift
//  Ai!SingAlong
//
//  Created by Kyle Brooks Robinson on 9/10/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit
import Parse
import Bolts

class SongInfoViewController: UIViewController {

    var setData: PFObject!
    
    var isAdding: Bool = true
    
    @IBOutlet weak var songNameField: UITextField!
    @IBOutlet weak var artistField: UITextField!
    @IBOutlet weak var albumField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Here's my Set Data for this VC: \(setData)")
        
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

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if isAdding == false {
            
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donePressed(sender: AnyObject) {
        
        setData["artistName"] = artistField.text
        setData["songName"] = songNameField.text
        setData["albumName"] = albumField.text
        setData["albumYear"] = Int(yearField.text!)
        
        setData.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            
            if error == nil {
                
                let blockVC = self.storyboard?.instantiateViewControllerWithIdentifier("blockVC") as! BlockViewController
                
                
                
                self.navigationController?.pushViewController(blockVC, animated: true)
                
                
            } else {
                
                print("Error: \(error)")
                
            }
            
        }
        
    }

    @IBAction func backButtonPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
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
