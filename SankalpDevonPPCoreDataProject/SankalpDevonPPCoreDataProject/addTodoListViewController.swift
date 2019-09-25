//
//  addTodoListViewController.swift
//  SankalpDevonPPCoreDataProject
//
//  Created by MAC on 9/23/19.
//  Copyright © 2019 PaulRenfrew. All rights reserved.
//
import UIKit
import Foundation

protocol AddToDoListViewControllerDelegate{
    func updateArray(with newValue : String?)
}

class addTodoListViewController: UIViewController  {
    var toDoItems = [String]()
    var previousScreen: AddToDoListViewControllerDelegate?
    
  @IBOutlet weak var inputItem: UITextField!
    var todoItem : String?
  
    
  @IBAction func addItem(_ sender: UIButton) {
    previousScreen?.updateArray(with: inputItem.text)
    navigationController?.popViewController(animated: true)
}
    
}
