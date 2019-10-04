//
//  CoreDataManager.swift
//  TestImageDisplay
//
//  Created by MCS on 10/4/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation
import CoreData
class CoreDataManager {
static let shared = CoreDataManager()
    private init() {}
    // c
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Picture")
        //s
        container.loadPersistentStores(completionHandler: {
            (description, error) in
                print(description)
                print(error)
        })
        return container
    }()
    //c
    var context: NSManagedObjectContext{
        return container.viewContext
    }
    func save(){
        guard context.hasChanges else{return}
        try? context.save()
    }
    func getAllFavoritePics() -> [PictureEntity]{
        let fetchRequest: NSFetchRequest<PictureEntity> = PictureEntity.fetchRequest()
        let gatherPics = try? context.fetch(fetchRequest)
        return gatherPics ?? []
    }

    }


