//
//  Address.swift
//  Solution
//
//  Created by Nick Adcock on 7/19/16.
//  Copyright © 2016 NEA. All rights reserved.
//

import Foundation
import CoreData


class Address: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    init(street: String, suite: String, city: String, zip: String, geo: Geo, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Address", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        self.street = street
        self.suite = suite
        self.city = city
        self.zip = zip
        self.geo = geo
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
}
