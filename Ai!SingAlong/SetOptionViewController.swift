//
//  SetOptionViewController.swift
//  Ai!SingAlong
//
//  Created by Kyle Brooks Robinson on 9/8/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit
import Parse
import Bolts

class SetOptionViewController: UIViewController {

    @IBOutlet weak var setlistName: UILabel!
    
    var identifier = ""
    var password = ""
    
    //setlistName
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
    }

    @IBAction func editSetPressed(sender: AnyObject) {
        
        let newEditSet = UIStoryboard(name: "NewEditSet", bundle: nil)
        
        let setlistMenuVC = newEditSet.instantiateViewControllerWithIdentifier("setlistMenuVC") as! SetlistMenuViewController
        
        setlistMenuVC.setToLoad = identifier
    
        self.navigationController?.pushViewController(setlistMenuVC, animated: true)
        
    }
    
    @IBAction func runSetPressed(sender: AnyObject) {
    
        
    
    }
    
    @IBAction func watchSetPressed(sender: AnyObject) {
        
        
        
    }

}







