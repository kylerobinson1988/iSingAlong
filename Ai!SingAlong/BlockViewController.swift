//
//  BlockViewController.swift
//  Ai!SingAlong
//
//  Created by Kyle Brooks Robinson on 9/10/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit
import Parse
import Bolts

class BlockViewController: UITableViewController, blockEditDelegate {

    let blockPicker = EditBlockViewController()
    
    var songId: String!
    var songData: [ParseData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
    }

    func loadInfo() {
        
        let setQuery: PFQuery = PFQuery(className: songId)
        
        setQuery.getObjectInBackgroundWithId(songId, block: { (songResponse, error) -> Void in
            
            if error == nil {
                
                let infoFromParse = songResponse as! [[String:AnyObject]]
                
                for item in infoFromParse {
                    
                    let title = songResponse[item]["blockTitle"]
                    let block = songResponse[item]["blockTitle"]
                    
                    var parseBlockInfo = ParseData(blockContents: block, blockTitle: title)
                    
                }
                
            } else {
                
                println("Error with data: \(error)")
                
            }
            
            
        })
        
            
            self.tableView.reloadData()
            
            println("Set Data: \(self.songData)")
        
    }
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        
        let editBlockVC = storyboard?.instantiateViewControllerWithIdentifier("editBlockVC") as! EditBlockViewController
        
        editBlockVC.delegate = self
        
        navigationController?.presentViewController(editBlockVC, animated: true, completion: nil)
        
    }
    
    func editBlockDidFinish(blockInfo: ParseData) {
        
        songData.append(blockInfo)
        
        tableView.reloadData()
        
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return songData.count
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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
