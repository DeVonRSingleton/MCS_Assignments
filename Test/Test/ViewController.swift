//
//  ViewController.swift
//  Test
//
//  Created by MCS on 9/20/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    
    var arrayPassed = [Any]()
    var keyArray : [ String] = []
    var dictionaryPassed = [String : Any]() 
    var valueArray : [Any] = []
    var url =  "https://api.tvmaze.com/shows/82?embed=seasons&embed=episodes"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self as! UITableViewDataSource
        tableView.delegate = self
        
        guard let url = URL(string: "https://api.tvmaze.com/shows/82?embed=seasons&embed=episodes") else{return}
        
        URLSession.shared.dataTask(with:url){(data, response, error)  in
        // Do any additional setup after loading the view.
        //print(data)
        //print(response)
        //print(error)
        //checking for data
        guard let data = data else{return print("No data")}
        //creating dictionary
        let dictionaryGameOfThrone = (try? JSONSerialization.jsonObject(with: data, options: [])) as?[String:Any]
            
            for (k, v) in dictionaryGameOfThrone! {
                self.arrayPassed.append("\(k) \(v)") //you are assigning dictionary values from the pokemon dictionary in your dictArray, however, your first dictArray is an array of dictionaries, but the dictArray you created in line 50 is just an array of strings. Maybe swift already knows to assign this to the dictionary array and not the string array?
            }
            
            let keyss = dictionaryGameOfThrone?.keys
            let values = dictionaryGameOfThrone?.values
        
            for key in keyss! {
                self.keyArray.append("\(key)")}
            for value in values! {
                self.valueArray.append("\(value)")}
            
            
            self.dictionaryPassed = dictionaryGameOfThrone!
            
            
            //print(keyss)
            //print(values)
            //print("keys array")
            //print(self.keyArray )
            //print("value array")
            //print(self.valueArray)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            }.resume()


}

}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.keyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
     
       let keySorted = self.keyArray.sorted()
       
        
        
        cell.textLabel?.text = keySorted[indexPath.row]
        
        //arrayPassed delete the ooptional text to make it clean but wasnt sorted so didnt go in order
        
        switch dictionaryPassed[keySorted[indexPath.row]] {
        case is String :
        cell.detailTextLabel?.text = dictionaryPassed[keySorted[indexPath.row]] as! String
        case is Int :
        cell.detailTextLabel?.text = "\(dictionaryPassed[keySorted[indexPath.row]] as! Int)"
        
        case is Dictionary<String, Any> :
            cell.detailTextLabel?.text = "\(dictionaryPassed[keySorted[indexPath.row]] as! Dictionary < String,Any >)"
        case is Array<Any> :
            // [Array<Dictionary<String, Any>>] :
            cell.detailTextLabel?.text = "\(dictionaryPassed[keySorted[indexPath.row]] as! Array <Any>)"//Array<Dictionary<String, Any>>)"
        case is URL:
            cell.detailTextLabel?.text = "\(dictionaryPassed[keySorted[indexPath.row]] as? URL)"
        case is NSNull:
            cell.detailTextLabel?.text = "Null Value"
        default: 
            
            print("thank you")
            print(arrayPassed)
        }
        return cell
        
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = self.keyArray.sorted()[indexPath.row]
        var value = dictionaryPassed[key]
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyBoard.instantiateViewController(withIdentifier: "detailPage") as! ViewController
        navigationController?.pushViewController(detailViewController, animated: true)
        
        
        
        
        //let keySorted = self.keyArray.sorted()
        

        
        
        
        /*switch dictionaryPassed[keySorted[indexPath.row]] {
        case is String :
            navigationController?.pushViewController(detailViewController, animated: true)
            
            detailViewController.url = value as!String
            //cell.detailTextLabel?.text = dictionaryPassed[keySorted[indexPath.row]] as! String
        case is Int :
            //cell.detailTextLabel?.text = "\(dictionaryPassed[keySorted[indexPath.row]] as! Int)"
            print("Number Slumber")
        case is Dictionary<String, Any> :
            navigationController?.pushViewController(detailViewController, animated: true)
            
            detailViewController.url = value as! String      //cell.detailTextLabel?.text = "\(dictionaryPassed[keySorted[indexPath.row]] as! Dictionary < String,Any >)"
        case is [Array<Dictionary<String, Any>>] :
            navigationController?.pushViewController(detailViewController, animated: true)
            
            detailViewController.url = value as!String
            //cell.detailTextLabel?.text = "\(dictionaryPassed[keySorted[indexPath.row]] as! Array<Dictionary<String, Any>>)"
        case is URL:
            navigationController?.pushViewController(detailViewController, animated: true)
            
            detailViewController.url = value as!String
            //cell.detailTextLabel?.text = "\(dictionaryPassed[keySorted[indexPath.row]] as? URL)"
        case is NSNull:
            print("where is it look in the eyes -> 00")
            //cell.detailTextLabel?.text = "Null Value"
        default:
         
         print("thank you")
         
         navigationController?.pushViewController(detailViewController, animated: true)
         detailViewController.url = "www.google.com"

 */
 
    }
}
