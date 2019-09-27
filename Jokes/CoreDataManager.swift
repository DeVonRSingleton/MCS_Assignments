//
//  CoreDataManager.swift
//  Jokes
//
//  Created by MCS on 9/27/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation
import CoreData



class CoreDataManager {
static let shared = CoreDataManager()
    private init() {}
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "JokesModel")
        container.loadPersistentStores(completionHandler: { (desciption, error) in
            print(desciption)
            print(error)
        })
        return container
    }()
     
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    func save(){
        guard context.hasChanges else {return}
        try? context.save()
    }
    func getAllFavoriteJokes() -> [Jokes]{
        let fetchRequest: NSFetchRequest<Jokes> = Jokes.fetchRequest()
        let gatherJokes = try? context.fetch(fetchRequest)
        return gatherJokes ?? []
    }


    }


