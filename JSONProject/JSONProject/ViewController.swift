//
//  ViewController.swift
//  JSONProject
//
//  Created by MCS on 9/16/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //getting access to Json need to know where the data is (SwIFT FILE location IS URL via bundle)
       //safe unwrapping guard let
        guard let jsonURL = Bundle.main.url(forResource: "PokemonExample", withExtension: "json"),
        
        //getting data could cause error so we will try it (try? optional if it nil it return nil)
        let data =  (try? Data(contentsOf: jsonURL)),
            
        // createa decoder = jsondecoder() then decoding from data and trying to create a pokemon out of it
        let pokemon = try? JSONDecoder().decode(Pokemons.self, from: data)
        else {return}
            // taking data from file and trying to create json object(dictionary or array) (as? [String: Any] checking to see if it a dictionary )(: in the middle make it a dictionary  so it looking for key name String with any value String : any)
            /*let jsonDictionary = ( try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]) else {return}
        */
        //creating a pokemon with our json dictionary
        //print(Pokemon(jsonDictionary: jsonDictionary))
    print(pokemon)
    
    }
}

struct Pokemon {
    let name : String
    // setting all the properties to it values with initializing the Pokemon with the jsonDictionary
    //init? = could potentially fail so giving us an optional (optional intializer : where we dont receive a key name name or the value is not a string)
    init?(jsonDictionary: [String: Any]){
    guard let name = jsonDictionary["name"] as? String
        else{return nil}
    self.name = name
        
    }
}

struct Pokemons: Codable
{
    let name: String
    let abilities: [Ability]
    let base_experience : Int
    let stats : [Stat]
    let sprites : Sprites
    
}

struct Sprites: Codable {
    let back_default : String
    let back_female : String?
    let back_shiny : String
    let back_shiny_female : String?
    let front_default : String
    let front_female : String?
    let front_shiny : String
    let front_shiny_female : String?
}

struct Stat: Codable {
    let base_stat : Int
    let effort : Int
    let name : String

    enum CodingKeys2: String, CodingKey {
        case base_stat
        case effort
        case stat
    }
    // name is inside of stat dictionary which is inside of a stats array. Stats array contain multiple dictionaries. each dictionary has another dictionary for stat
    enum StatContainerCodingKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        // container is at top level so it see stats which is an array that contain dictionaries
        let container = try decoder.container(keyedBy: CodingKeys2.self)
       //nested container is for name since name is in a dictionary of stat . and stat is a part of an array that contain dictionaries
        let statContainer = try container.nestedContainer(keyedBy: StatContainerCodingKeys.self, forKey: .stat)
        base_stat = try container.decode(Int.self, forKey: .base_stat)
        effort = try container.decode(Int.self, forKey: .effort)
        name = try statContainer.decode(String.self, forKey: .name)
    }

}

struct Ability: Codable{
    let isHidden : Bool
    let slot : Int
    let name : String
    //
    //coding keys to change the name from what the key is in json file
    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case slot = "slot"
        case ability = "ability"
    }
    enum AbilityContainerCodingKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        // container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let abilityContainer = try container.nestedContainer(keyedBy: AbilityContainerCodingKeys.self, forKey: .ability)
        isHidden = try container.decode(Bool.self, forKey: .isHidden)
        slot = try container.decode(Int.self, forKey: .slot)
        name = try abilityContainer.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var abilityContainer = container.nestedContainer(keyedBy: AbilityContainerCodingKeys.self , forKey: .ability)
        try abilityContainer.encode(name, forKey: .name)
        try container.encode(isHidden, forKey: .isHidden)
        try container.encode(slot, forKey: .slot)
    }
 }
