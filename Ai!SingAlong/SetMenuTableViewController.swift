//
//  SetMenuTableViewController.swift
//  Ai!SingAlong
//
//  Created by Kyle Brooks Robinson on 9/8/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit
import Parse
import Bolts

class SetMenuTableViewController: UITableViewController {

    var setlists = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadParseData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        loadParseData()
        
    }

    func loadParseData() {
        
        let setlistQuery = PFQuery(className:"setlist")
        
        setlistQuery.findObjectsInBackgroundWithBlock { (setlistInfo, error) -> Void in
            
            print("Setlist Info: \(setlistInfo)")
            
            self.setlists = setlistInfo!
            
            self.tableView.reloadData()
        }
        
    }

    @IBAction func addButtonPressed(sender: AnyObject) {
        
        let newSetVC = storyboard?.instantiateViewControllerWithIdentifier("newSetVC") as! NewSetViewController
        
        presentViewController(newSetVC, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return setlists.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("setCell", forIndexPath: indexPath) as! SetCell
        
        let identifier = setlists[indexPath.row].objectId
        
        cell.setName.text = setlists[indexPath.row]["name"] as? String
        cell.setDate.text = setlists[indexPath.row]["date"] as? String
        cell.identifier = identifier

        // Configure the cell...

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let setOptionVC = storyboard?.instantiateViewControllerWithIdentifier("setOptionVC") as! SetOptionViewController
        
        setOptionVC.identifier = setlists[indexPath.row].objectId
        setOptionVC.name = setlists[indexPath.row]["name"] as? String
        
        if let password = setlists[indexPath.row]["password"] as? String {
            
            if password != "none" {
                
                setOptionVC.password = password
                
            }
            
        }
        
        self.navigationController?.setToolbarHidden(true, animated: true)
        
        self.navigationController?.pushViewController(setOptionVC, animated: true)
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
