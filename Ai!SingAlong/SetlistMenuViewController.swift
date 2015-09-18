//
//  SetlistMenuViewController.swift
//  Ai!SingAlong
//
//  Created by Kyle Brooks Robinson on 9/8/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit
import Parse
import Bolts

class SetlistMenuViewController: UITableViewController {

    var setToLoad: String!
    var setData: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
                
    }
    
    override func viewDidAppear(animated: Bool) {
        
        print("Set Data: \(setData)")
        
        self.navigationController?.setToolbarHidden(false, animated: false)
        
    }
    
    @IBAction func addButtonClicked(sender: AnyObject) {
        
        let editSongNavVC = storyboard?.instantiateViewControllerWithIdentifier("editSongNavVC") as! UINavigationController
        
        let infoVC = (editSongNavVC.viewControllers[0] as! SongInfoViewController)
        
        infoVC.setData = setData
        
        presentViewController(editSongNavVC, animated: true, completion: nil)
        
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
        
        return setData["songInfo"]!.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("setlistMenuCell", forIndexPath: indexPath) as! SetlistMenuCell

        let songInfo = setData["songInfo"] as! [[String:AnyObject]]
        
        if let albumName = songInfo[indexPath.row]["albumName"] as? String {
            
            let year = songInfo[indexPath.row]["albumYear"] as? Int
            
            let fullLabel = "\(albumName), \(year!)"
            
            cell.songName.text = songInfo[indexPath.row]["songName"] as? String
            cell.albumName.text = fullLabel
            cell.artistName.text = songInfo[indexPath.row]["artistName"] as? String
            
        }
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let songInfoVC = storyboard?.instantiateViewControllerWithIdentifier("songInfoVC") as! SongInfoViewController
        
        songInfoVC.setData = setData
        
        self.navigationController?.pushViewController(songInfoVC, animated: true)
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
//            let query = PFQuery(className: setToLoad)
//            
//            let objectToDelete = setData[indexPath.row].objectId!
//            
//            let deletion = query.getObjectWithId(objectToDelete!)
//            
//            deletion?.deleteInBackground()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
