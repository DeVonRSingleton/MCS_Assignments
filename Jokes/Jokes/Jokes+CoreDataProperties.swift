//
//  Jokes+CoreDataProperties.swift
//  Jokes
//
//  Created by MCS on 9/30/19.
//  Copyright © 2019 MCS. All rights reserved.
//
//

import Foundation
import CoreData


extension Jokes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Jokes> {
        return NSFetchRequest<Jokes>(entityName: "Jokes")
    }

    @NSManaged public var category: String
    @NSManaged public var delivery: String
    @NSManaged public var id: Int16
    @NSManaged public var joke: String
    @NSManaged public var setup: String
    @NSManaged public var type: String

}
