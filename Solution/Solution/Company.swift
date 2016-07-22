//
//  Company.swift
//  Solution
//
//  Created by Nick Adcock on 7/19/16.
//  Copyright © 2016 NEA. All rights reserved.
//

import Foundation
import CoreData


class Company: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    init(name: String, catchPhrase: String, bs: String, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Company", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
}
