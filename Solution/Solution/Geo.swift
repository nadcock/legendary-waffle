//
//  Geo.swift
//  Solution
//
//  Created by Nick Adcock on 7/19/16.
//  Copyright © 2016 NEA. All rights reserved.
//

import Foundation
import CoreData


class Geo: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    init(lat: String, lng: String, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Geo", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        self.lat = Double(lat)
        self.lat = Double(lng)
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
}
