//
//  ViewController.swift
//  DataBinding
//
//  Created by MCS on 10/13/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var arrayList : [String] = ["Peter Pan","Panmania","Peter Griffin" , "Undertaker", "Kane", "Big Show"]
    @IBOutlet var tableView: UITableView!
    @IBOutlet var theLabel: UILabel!
    var updatedStringText : String?
    
    func updateString(with value: String){
        guard let selectedRow = tableView.indexPathForSelectedRow?.row else {return}
        arrayList[selectedRow] = value
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self 
        tableView.delegate = self
        tableView.register(UITableViewCell.self , forCellReuseIdentifier: "cell")
    }
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = arrayList[indexPath.row]
        return cell
    }
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(identifier: "NextViewController") as! NextViewController
        let customTextString = arrayList[indexPath.row]
        nextViewController.textString = customTextString
        navigationController?.pushViewController(nextViewController, animated: true)
  
    }
}

