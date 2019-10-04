//
//  DetailViewController.swift
//  RandomPokemon
//
//  Created by MCS on 10/2/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation
import UIKit
class DetailViewController : UIViewController {
    
    @IBAction func backButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    var pokemonDetail : Details!
    let detailsPokemon = Pokemon.self
    var urlString: String = ""
    var imgUrl: String = ""
    var name : String = ""
    var order : Int = 0
    
    @IBOutlet var picture: UIImageView!
    @IBOutlet var detailLabel: UILabel!
    
    
    
    func followThatApiDetails(input: String, completion: @escaping (Details) -> Void ){
        guard let url = URL(string: input)else{return}
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard let data = data else{print("no data")
                return   }
            do{
                let pokemonDetails = try JSONDecoder().decode(Details.self, from: data)
                self.pokemonDetail = pokemonDetails
                
                print(self.pokemonDetail)
                print("This is details")
                
                
            }
            catch{
                print(error.localizedDescription)
                
            }
            completion(self.pokemonDetail)
        }.resume()
        
        //////*https://pokeapi.co/api/v2/pokemon-species/
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: imgUrl)else{return}
        URLSession.shared.dataTask(with: url) { (data, _,_) in
            guard let data = data, let image = UIImage.init(data: data)
                else{return}
            DispatchQueue.main.async {
                
                self.picture.image = image
            }
            
        }.resume()
        
        followThatApiDetails(input: urlString) { (pokemonDetail) in
            for value in pokemonDetail.flavor_text_entries{
                if value.language.name == "en" {
                    DispatchQueue.main.async{
                        self.detailLabel.text = "\(self.name)\n\n \(self.order)\n\n\(value.flavor_text)"
                    }
                    
                }
            }
            
            
        }
        
        
        
    }
    
    
    
    
}

