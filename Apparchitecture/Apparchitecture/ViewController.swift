//
//  ViewController.swift
//  Apparchitecture
//
//  Created by MCS on 10/1/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var clueTable: UITableView!
    
    var cluesArray: [Clue] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        clueTable.dataSource = self
        guard let url = URL(string: "http://jservice.io/api/clues")else{return}
        URLSession.shared.dataTask(with: url) {[weak self] (data,_,_ )in
            guard let data = data ,let clues = try?JSONDecoder().decode([Clue].self, from: data) else {
                
                return
            }
        }
        // Do any additional setup after loading the view.
        
    }
}

extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "clueCell")
        cell.textLabel?.text = cluesArray[indexPath.row].question
        cell.detailTextLabel?.text = cluesArray[indexPath.row].answer
        return cell
    }
}
struct Clue : Codable {
    let question : String
    let answer : String
    }
