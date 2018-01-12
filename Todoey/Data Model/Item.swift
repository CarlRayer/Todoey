//
//  Item.swift
//  Todoey
//
//  Created by Carl on 10/01/2018.
//  Copyright © 2018 Carl. All rights reserved.
//

import Foundation

// mark class as encodable, all properties must be standard data types

class Item: Codable {
    var title : String = ""
    var done: Bool = false
}
