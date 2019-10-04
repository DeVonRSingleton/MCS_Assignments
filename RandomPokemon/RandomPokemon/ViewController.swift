//
//  ViewController.swift
//  RandomPokemon
//
//  Created by MCS on 10/1/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let dispatchGroup = DispatchGroup()
    

    func followThatApi(){
        dispatchGroup.enter()
               guard let url = URL(string:"https://pokeapi.co/api/v2/pokemon/\(Int.random(in: 0...806))" )else{return}
                URLSession.shared.dataTask(with: url){ (data, response, error) in
                        guard let data = data else{print("no data")
                        return   }
                    do{
                        //let pokemon = try JSONDecoder().decode(PokemonCodable.self, from: data)
                        let pokemonRandom = try JSONDecoder().decode(Pokemon.self, from: data)
                        self.pokemonArray.append(pokemonRandom)
                        
//                        if pokemonRandom.species != nil {
//                        self.followThatApi(input: pokemonRandom.species.url)
//                        } else {
//
//                        }
                        print(self.pokemonArray)
                        print("This is working")
                        self.dispatchGroup.leave()
                    }
                    catch{
        //                let pokemonDictionary = (try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] )
        //
        //                print("dict")
        //                print(pokemonDictionary)
                        print(error.localizedDescription)
                       
                    }
                    
            
                }.resume()
    }
    
    
    @IBOutlet var tableView: UITableView!
    
    var pokemonArray : [Pokemon] = []
    //var pokemonArray : [PokemonCodabale] = []
    //var dummyArray : [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self as UITableViewDataSource
        tableView.delegate = self
        
        followThatApi()
        followThatApi()
        followThatApi()
        followThatApi()
        followThatApi()
        followThatApi()
        
        
        // Do any additional setup after loading the view.
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }


}
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
       
        
        cell.textLabel?.text = "Pokemon Name: \(pokemonArray[indexPath.row].species.name)"
        cell.detailTextLabel?.text = "ID: \(pokemonArray[indexPath.row].order)"
        return cell
    }
    
    
    
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let url = pokemonArray[indexPath.row].species.url
        let image = pokemonArray[indexPath.row].sprites.front_default
        let name = pokemonArray[indexPath.row].species.name
        let order = pokemonArray[indexPath.row].order
        
        
        print("This is the url required \(url)")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        
        detailViewController.urlString = url
        detailViewController.imgUrl = image
        detailViewController.name = name
        detailViewController.order = order
        
        detailViewController.transitioningDelegate = self
        
        present(detailViewController, animated: true, completion: nil)
    }
    

}

extension ViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Transition()
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Transition()
    }
}


