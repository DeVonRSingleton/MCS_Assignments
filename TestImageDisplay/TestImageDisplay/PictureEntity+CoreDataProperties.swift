//
//  PictureEntity+CoreDataProperties.swift
//  TestImageDisplay
//
//  Created by MCS on 10/4/19.
//  Copyright © 2019 MCS. All rights reserved.
//
//

import Foundation
import CoreData


extension PictureEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PictureEntity> {
        return NSFetchRequest<PictureEntity>(entityName: "PictureEntity")
    }

    @NSManaged public var totalHits: Int64
    @NSManaged public var hits: Int64
    @NSManaged public var previewURL: String?
    @NSManaged public var downloads: Int64
    @NSManaged public var likes: Int64
    @NSManaged public var largeImageURL: String?
    @NSManaged public var views: Int64
    @NSManaged public var total: Int64
    
    @NSManaged public var favorites: Int64
    
}
