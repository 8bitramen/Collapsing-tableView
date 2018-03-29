//
//  ExpandableNames.swift
//  TableView
//
//  Created by Leahy, William on 1/23/18.
//  Copyright © 2018 Leahy, William. All rights reserved.
//

import Foundation

struct ExpandableNames {
    var isExpanded : Bool
    var names : [Contact]
}

struct Contact {
    let name : String
    var isFavorited : Bool {
        didSet {
            print(isFavorited)
        }
    }
}
