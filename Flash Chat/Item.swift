//
//  Item.swift
//  Flash Chat
//
//  Created by Fiza Rasool on 17/05/20.
//  Copyright © 2020 Fiza Rasool. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
