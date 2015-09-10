//
//  SongInfoViewController.swift
//  Ai!SingAlong
//
//  Created by Kyle Brooks Robinson on 9/10/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

class SongInfoViewController: UIViewController {

    @IBOutlet weak var songNameField: UITextField!
    @IBOutlet weak var artistField: UITextField!
    @IBOutlet weak var albumField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var editBlocksPressed: MainButton!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
