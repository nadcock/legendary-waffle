//
//  Album.swift
//  Solution
//
//  Created by Nick Adcock on 7/19/16.
//  Copyright © 2016 NEA. All rights reserved.
//

import Foundation
import CoreData


class Album: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    init(albumID: Int, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Album", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        self.id = albumID
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
}
