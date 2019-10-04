//
//  ViewController.swift
//  TestImageDisplay
//
//  Created by MCS on 10/4/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var picArray : [PictureEntity] = []
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        guard let url = URL(string: "https://pixabay.com/api/?key=13840202-ac6b0a765e9edd3e9a35cfaa2&q=pretend&image_type=photo&pretty=true") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
          
            do {
                let data = data ; let picture = try JSONDecoder().decode(PictureEntity.self, from: data!)
                print(picture)
                self.picArray.append(picture)
            } catch{
                print(error.localizedDescription)
                    }
            
         // try? CoreDataManager.shared.context.save()
          DispatchQueue.main.async {
            
            
          }
        }.resume()
    }
    
    


}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.detailTextLabel?.text = "hey"
        return cell
    }
}

