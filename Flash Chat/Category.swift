//
//  Category.swift
//  Flash Chat
//
//  Created by Fiza Rasool on 17/05/20.
//  Copyright © 2020 Fiza Rasool. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc  dynamic var name : String = ""
    @objc dynamic var catColor : String = ""
    
    let items = List<Item>()
}
