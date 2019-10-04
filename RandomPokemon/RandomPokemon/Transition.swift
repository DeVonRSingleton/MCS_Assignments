//
//  Transition.swift
//  RandomPokemon
//
//  Created by MCS on 10/2/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation

import UIKit

class Transition: NSObject, UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 2
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let detailViewController: DetailViewController
    var isBeingPresented = false
    if let detailVC = transitionContext.viewController(forKey: .to) as? DetailViewController {
      detailViewController = detailVC
      isBeingPresented = true
    } else if let detailVC = transitionContext.viewController(forKey: .from) as? DetailViewController {
     detailViewController = detailVC
      isBeingPresented = false
    } else {
      return
    }
    
    guard let detailView = detailViewController.view else { return }
    transitionContext.containerView.addSubview(detailView)
    if isBeingPresented {
      detailView.frame.origin.x = -UIScreen.main.bounds.width
      detailView.frame.origin.y = UIScreen.main.bounds.height
    } else {
      detailView.frame.origin.x = 0
        detailView.frame.origin.y = 0
      
    }
    UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
      if isBeingPresented {
        detailView.frame.origin.x = 0
        detailView.frame.origin.y = 0
      } else {
        detailView.frame.origin.x = UIScreen.main.bounds.width
        detailView.frame.origin.y = UIScreen.main.bounds.height
        
      }
    }) { (completed) in
        transitionContext.completeTransition(completed)
    }
  }
}
