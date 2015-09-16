//
//  ParseData.swift
//  Ai!SingAlong
//
//  Created by Kyle Brooks Robinson on 9/16/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

struct ParseData {
    
    var title: String!
    var contents: String!
    
    
    init(blockContents: String, blockTitle: String) {
        
        self.title = blockTitle
        self.contents = blockContents
        
    }
    
}
