//
//  PictureEntity+CoreDataClass.swift
//  TestImageDisplay
//
//  Created by MCS on 10/4/19.
//  Copyright © 2019 MCS. All rights reserved.
//
//

import Foundation
import CoreData
@objc(PictureEntity)
public class PictureEntity:  NSManagedObject , Codable {

    struct PictureTime: Codable{
        let totalHits : Int64
        let hits : [Hits]
        let total : Int64
    
        enum codingKeys : String, CodingKey {
            case totalHits
            case hits
            case total
        }
        
    
    }
    struct Hits : Codable {
        let previewURL : String
        let largeImageURL : String
        let downloads : Int64
        let likes : Int64
        let views : Int64
        let favorites : Int
        }
    enum codingKeys : String, CodingKey {
        case previewURL
        case largeImageURL
        case downloads
        case likes
        case views
        case favorites
        }
    public convenience required init(from decoder: Decoder) throws{
        guard let description = NSEntityDescription.entity(forEntityName: "PictureEntity", in: CoreDataManager.shared.context) else {throw
            CoreDataErrors.invalidEnityDescription}
        
        self.init(entity: description, insertInto: CoreDataManager.shared.context)
        let container = try decoder.container(keyedBy: codingKeys.self)
        previewURL = try container.decode(String.self, forKey:.previewURL)
        largeImageURL = try container.decode(String.self, forKey: .largeImageURL)
        downloads = try container.decode(Int64.self, forKey: .downloads)
        likes = try container.decode(Int64.self, forKey: .likes)
        views = try container.decode(Int64.self, forKey: .views)
        favorites = try container.decode(Int64.self, forKey: .favorites)
        }
    public func encode(to encoder: Encoder) throws {
//       var container = encoder.container(keyedBy: codingKeys.self)
//       try container.encode(name, forKey: .name)
     }
    
}




enum CoreDataErrors: Error {
    case invalidEnityDescription
}
