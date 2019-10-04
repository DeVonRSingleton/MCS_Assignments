//
//  PokemonCodable.swift
//  RandomPokemon
//
//  Created by MCS on 10/1/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation
import UIKit
struct Pokemon: Codable{
    let species : Species
    let order : Int
    let sprites : Sprites
    
}
struct Sprites: Codable {
    let front_default : String
}
struct Species : Codable {
    let name : String
    let url : String
}

struct Details : Codable{
    let flavor_text_entries : [Flavor_Text_Entries]
}
struct Flavor_Text_Entries: Codable{
    let flavor_text : String
    let language : Language
}
struct Language : Codable {
   let name : String
}
