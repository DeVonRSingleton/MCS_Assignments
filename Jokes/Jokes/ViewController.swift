//
//  ViewController.swift
//  Jokes
//
//  Created by MCS on 9/27/19.
//  Copyright © 2019 MCS. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    var url = ""
    var jokesArray: [Jokes] = []
    var filterJokesArray: [Jokes] = []
    var favoriteJokesArray: [Jokes] = []
    var jokeType = "Any"
    
    func whatSegment() {
   
    switch segmentedControl.selectedSegmentIndex{
            case 0:
                jokeType = "Any"
                filterTableByCategory(category: jokeType)
                self.url = "https://sv443.net/jokeapi/category/Any"
                print(url)
    //            DispatchQueue.main.async {
    //                self.tableView.reloadData()
    //            }
            case 1:
                jokeType = "Programming"
                filterTableByCategory(category: jokeType)
                self.url = "https://sv443.net/jokeapi/category/Programming"
                print(url)
    //            DispatchQueue.main.async {
    //                self.tableView.reloadData()
    //            }
            case 2:
                jokeType = "Miscellaneous"
                filterTableByCategory(category: jokeType)
                self.url = "https://sv443.net/jokeapi/category/Miscellaneous"
                print(url)
    //            DispatchQueue.main.async {
    //                self.tableView.reloadData()
    //            }
            case 3:
                jokeType = "Dark"
                filterTableByCategory(category: jokeType)
                self.url = "https://sv443.net/jokeapi/category/Dark"
                print(url)
    //            DispatchQueue.main.async {
    //                self.tableView.reloadData()
    //            }
            case 4:
                self.url = " " //
            default:
                break
                }
            guard let theUrl = URL(string: url) else {print("no link")
                 return}
             URLSession.shared.dataTask(with: theUrl){(data,task,error) in
             guard let data = data else { print("no data")
                 return          }
            do{ let jokesDecode = try JSONDecoder().decode(Jokes.self, from: data)
                self.jokesArray.append(jokesDecode)
                 }catch
                 {let jsonDictionary =  (try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any])
    //             print("dict")
    //             print("JsonDictionary:",jsonDictionary)
                 print(error.localizedDescription)
             }
            DispatchQueue.main.async {
                           self.tableView.reloadData()
                                                }
             }.resume()
            }

    func filterTableByCategory(category: String){
        filterJokesArray.removeAll()
        //favoriteJokesArray.removeAll()
        for joke in jokesArray{
            if self.url == "https://sv443.net/jokeapi/category/\(jokeType)"{
                filterJokesArray.append(joke)
            } else if joke.category == category{
                filterJokesArray.append(joke)
            }}}
    @IBAction func tabChanged(_ sender: Any) {
        //self.jokesArray.removeAll()
        whatSegment()
        //filterTableByCategory(category: jokeType)
    }
    func singleOrTwoParter(joke: Jokes) -> String {
        if joke.type == "single" {
            return "Joke: " + joke.joke
        }
        else{ return "Setup: " + joke.setup + "\nDelivery: " + joke.delivery}
        }
    @IBAction func populateJoke(_ sender: UIButton) {
        whatSegment()
    }
    
    @IBOutlet var tableView: UITableView!
    
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    
    @IBAction func categoryDisplayed(_ sender:UISegmentedControl) {
        filterTableByCategory(category: jokeType)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(CoreDataManager.shared.getAllFavoriteJokes())
       // let savedArray = CoreDataManager.shared.getAllFavoriteJokes()
        //whatSegment()
   tableView.dataSource = self
   tableView.delegate = self as! UITableViewDelegate
   tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableCell")
        
        
    }
}

extension ViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterJokesArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! TableViewCell
        cell.label?.text = singleOrTwoParter(joke: filterJokesArray[indexPath.row])
        CoreDataManager.shared.save()
        
        return cell
        
    }
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        
    }
}
