//
//  Jokes+CoreDataClass.swift
//  Jokes
//
//  Created by MCS on 9/30/19.
//  Copyright © 2019 MCS. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Jokes)
public class Jokes: NSManagedObject , Codable {
    
    
    
    enum codingKey : String ,CodingKey {
               case category
               case type
               case id
               case setup
               case joke
               case delivery
           }

           public convenience required init(from decoder: Decoder) throws{
               
           guard let description = NSEntityDescription.entity(forEntityName: "Jokes", in: CoreDataManager.shared.context) else {throw CoreDataErrors.invalidEnityDescription }
               self.init(entity:description, insertInto: CoreDataManager.shared.context)
               let container = try decoder.container(keyedBy: codingKey.self)
             
              category = try container.decode(String.self, forKey: .category)
               
              id = try container.decode(Int16.self, forKey: .id)
              type = try container.decode(String.self, forKey: .type)
              if type == "single" {
                joke = try container.decode(String.self, forKey: .joke)
               }
               else{
               setup = try container.decode(String.self, forKey: .setup)
               delivery = try container.decode(String.self, forKey: .delivery)
            }}
       }
       
enum CoreDataErrors: Error {
    case invalidEnityDescription
}
