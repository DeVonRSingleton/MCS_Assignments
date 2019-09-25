//
//  ViewController.swift
//  SankalpDevonPPCoreDataProject
//
//  Created by MAC on 9/23/19.
//  Copyright © 2019 PaulRenfrew. All rights reserved.
//

import UIKit

class ViewController: UIViewController , AddToDoListViewControllerDelegate {
  
  var toDoItems : [String] = []
  @IBOutlet weak var toDoListTableView: UITableView!
    
  @IBAction func goToAddItemPage(_ sender: Any) {
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let detailViewController = storyBoard.instantiateViewController(withIdentifier: "addToDoList") as! addTodoListViewController
    detailViewController.previousScreen = self
   navigationController?.pushViewController(detailViewController, animated: true)
}
    func updateArray(with newValue: String?) {
        //safe unwrapping
        if let editText = newValue  {
            toDoItems.append(editText)
            toDoListTableView.reloadData()
            print(CoreDataManager.shared.createNewList(with: newValue!))
            CoreDataManager.shared.saveList()
        
        }
    }


  override func viewDidLoad() {
    super.viewDidLoad()
     CoreDataManager.shared.saveList()
     let newList = CoreDataManager.shared.getAllItems()
     for list in newList{toDoItems.append(list.item!)}
    print("new list")
    print(newList)
    toDoListTableView.dataSource = self
    toDoListTableView.delegate = self
    
    toDoListTableView.reloadData()
        }
}



extension ViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return toDoItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
      cell.textLabel?.text = toDoItems[indexPath.row]
    
    return cell
  }
}

extension ViewController: UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    toDoItems.remove(at: indexPath.row)
    CoreDataManager.shared.delListItem(at: indexPath.row)
    toDoItems.insert("You have completed the following tasks ", at: indexPath.row)
    self.toDoListTableView.reloadData()
    
  }
  
  
}
