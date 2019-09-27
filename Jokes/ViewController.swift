//
//  ViewController.swift
//  Jokes
//
//  Created by MCS on 9/27/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    func whatSegment() {
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            self.url = "https://sv443.net/jokeapi/category/Any"
            print(url)
        case 1:
            self.url = "https://sv443.net/jokeapi/category/Program"
            print(url)
        case 2:
            self.url = "https://sv443.net/jokeapi/category/Miscellaneous"
                print(url)
        case 3:
            self.url = "https://sv443.net/jokeapi/category/Dark"
            print(url)
        case 4:
            self.url = " " //
        default:
            break
        }
        
    }

var url = ""
var jokesArray: [Jokes] = []
    
    @IBAction func populateJoke(_ sender: UIButton) {
        
    
    }
    
    @IBOutlet var tableView: UITableView!
    
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBAction func categoryDisplayed(_ sender:UISegmentedControl) {
       whatSegment()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whatSegment()
        tableView.dataSource = self
   tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableCell")
        
        guard let theUrl = URL(string: url) else {print("no link")
            return}
        
        URLSession.shared.dataTask(with: theUrl){(data,task,error) in
       
        guard let data = data else { print("no data")
            return          }

        do {
        let jokesDecode = try JSONDecoder().decode([Jokes].self, from: data)
            self.jokesArray = jokesDecode
            print("jokes array")
            print(self.jokesArray)
            }
        catch{
            let jsonDictionary =  (try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any])
            print("dict")
            print(jsonDictionary)
            print(error.localizedDescription)
           // jokesArray = (jsonDictionary) as Array
            }
            
       DispatchQueue.main.async {
                      
                      self.tableView.reloadData()
                                           }
        }.resume()
    }
}

extension ViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! TableViewCell
        
        cell.label.text = "Coming soon"
        
       return cell
        
    }
}
