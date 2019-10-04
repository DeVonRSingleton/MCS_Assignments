//
//  ViewController.swift
//  MemoryManagementProject
//
//  Created by MCS on 9/30/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var hasShownSecondViewController = false
    
    //var person: Person?
    override func viewDidLoad() {
        super.viewDidLoad()
        let person = Person(name: "Ryan",home: nil)
        let home = Home(address: "Random", occupant: nil)
        person.home = home
        home.occupant = person
        print("\(person.name) moved into house at \(home.address)")
        //self.person = person
        // Do any additional setup after loading the view.
    }

   override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    guard !hasShownSecondViewController else {return}
    hasShownSecondViewController = true
       present(SecondViewController(), animated: true, completion: nil)
    }
    }

//cfretaing second viewcontroller
class SecondViewController: UIViewController{
    var count = 0
    deinit{print("Secondviewcontroller has been deinitialized")}
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dismiss(animated: true) {[weak self] in
            DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
                 for number in 0 ... 1000000{
                               self?.count += number
                               print(self?.count)
            }
            //capture list to break retainer list in this situation
           
            }
        }
        }
    }


class Person {
    var name: String = ""
    var home: Home?
    deinit {
        print("Person has been deintialized")
    }

    init(name: String, home: Home?)
    {
        self.name = name
        self.home = home
    }
}
class Home {
    let address: String
    weak var occupant: Person?//doesnt inccrease retain count cause of weakx
    deinit {
        print("Home has been deintialized")
    }
    init(address: String, occupant: Person?)
    {self.address = address
    self.occupant = occupant
    }
}
