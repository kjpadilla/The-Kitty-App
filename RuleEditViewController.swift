//
//  RuleEditViewController.swift
//  The Kitty App
//
//  Created by Kristofer Padilla on 12/10/17.
//  Copyright © 2017 Kristofer Padilla. All rights reserved.
//

import UIKit

class RuleEditViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blue
        
        setUpViews()
        
        // Do any additional setup after loading the view.
    }

    let editRuleView: UITextView = {
        let label = UITextView()
        label.backgroundColor = UIColor(red: 252/255, green: 237/255, blue: 244/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit() //multi-line?
        label.isScrollEnabled = false
        label.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //fills view to edges
        //label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpViews() {
        view.addSubview(editRuleView)
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[v0]-4-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": editRuleView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0]-500-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": editRuleView]))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
