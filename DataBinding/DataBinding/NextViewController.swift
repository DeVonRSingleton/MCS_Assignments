//
//  NextViewController.swift
//  DataBinding
//
//  Created by MCS on 10/13/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation
import UIKit
class NextViewController: UIViewController {
    @IBOutlet var textBox: UITextField!
    
    @IBAction func submit(_ sender: Any) {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let previousViewController = storyboard.instantiateViewController(identifier: "ViewController") as! ViewController
        let newTextString = textBox.text
        print(newTextString)
               previousViewController.updatedStringText = newTextString
        navigationController?.pushViewController(previousViewController, animated: true)
       }
    var textString : String?
      override func viewDidLoad() {
        super.viewDidLoad()
    //    //add observer
    //    //add observer to get changes made in the textfield
        textBox.text = textString
      }
    //
}
