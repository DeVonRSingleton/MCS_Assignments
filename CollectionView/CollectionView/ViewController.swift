//
//  ViewController.swift
//  CollectionView
//
//  Created by MCS on 10/2/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var exampleCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exampleCollectionView.dataSource = self
        exampleCollectionView.delegate = self
        exampleCollectionView.register(UICollectionViewCell.self , forCellWithReuseIdentifier: "colorCell")
    }
}

extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath)
        
        cell.backgroundColor = .randomColor()
        return cell
    }
    }
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension UIColor{
    //RETURNING UI COLOR
    static func randomColor() -> UIColor{
        //UIColor rangess from 0 to 1
        return UIColor(displayP3Red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
    }
}
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.backgroundColor = .randomColor()
    }
}
