//
//  Company+CoreDataProperties.swift
//  Solution
//
//  Created by Nick Adcock on 7/19/16.
//  Copyright © 2016 NEA. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Company {

    @NSManaged var name: String?
    @NSManaged var catchPhrase: String?
    @NSManaged var bs: String?
    @NSManaged var user: Company?

}
