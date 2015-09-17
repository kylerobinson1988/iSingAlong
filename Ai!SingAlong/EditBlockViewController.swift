//
//  EditBlockViewController.swift
//  Ai!SingAlong
//
//  Created by Kyle Brooks Robinson on 6/30/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

protocol blockEditDelegate {
    
    func editBlockDidFinish(blockInfo: ParseData)
    
}

class EditBlockViewController: UIViewController {
    
    @IBOutlet weak var blockTitle: UITextField!
    @IBOutlet weak var blockText: UITextField!
    
    var delegate: blockEditDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

    @IBAction func finishButtonPressed(sender: AnyObject) {
        
        let title = blockTitle.text!
        let block = blockText.text!
        
        let newBlock = ParseData(blockContents: block, blockTitle: title)
        
        delegate?.editBlockDidFinish(newBlock)
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    

}
