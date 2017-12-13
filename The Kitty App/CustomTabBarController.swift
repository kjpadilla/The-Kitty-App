//
//  CustomTabViewController.swift
//  The Kitty App
//
//  Created by Kristofer Padilla on 12/10/17.
//  Copyright © 2017 Kristofer Padilla. All rights reserved.
//

import UIKit

class customTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        let rulesCollectionViewController = RulesCollectionViewController(collectionViewLayout: flowLayout)
        let rulesNavController = UINavigationController(rootViewController: rulesCollectionViewController)
        rulesNavController.tabBarItem.title = "Rules"
        rulesNavController.tabBarItem.image = nil
        
        let ruleEditViewController = RuleEditViewController()
        let ruleEditNav = UINavigationController(rootViewController: ruleEditViewController)
        ruleEditNav.tabBarItem.title = "EDIT"
        ruleEditNav.tabBarItem.image = nil
        
        viewControllers = [rulesNavController, ruleEditNav]
        
        
    }
    
}
