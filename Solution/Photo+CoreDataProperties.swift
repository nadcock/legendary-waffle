//
//  Photo+CoreDataProperties.swift
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

extension Photo {

    @NSManaged var album: NSManagedObject?
    @NSManaged var id: NSNumber?
    @NSManaged var title: String?
    @NSManaged var url: String?
    @NSManaged var thumbnailURL: String?

}
