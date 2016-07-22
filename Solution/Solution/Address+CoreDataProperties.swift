//
//  Address+CoreDataProperties.swift
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

extension Address {

    @NSManaged var street: String?
    @NSManaged var suite: String?
    @NSManaged var city: String?
    @NSManaged var zip: String?
    @NSManaged var user: User?
    @NSManaged var geo: Geo?

}
