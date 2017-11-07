	//
//  ViewController.swift
//  The Kitty App
//
//  Created by Kristofer Padilla on 10/23/17.
//  Copyright © 2017 Kristofer Padilla. All rights reserved.
//

import UIKit

class RulesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout	{

    let customCellIdentifier = "customCellIdentifier"
    let theRules = [
    "Rule 1",
    "Rule 2",
    "Rule 3",
    "Rule 1",
    "Rule 2",
    "Rule 3",
    "Rule 1",
    "Rule 2",
    "Rule 3",
    "Rule 1",
    "Rule 2",
    "Rule 3"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "The Rules"
        
        collectionView?.backgroundColor = UIColor(red: 252/255, green: 237/255, blue: 244/255, alpha: 1)
        
        collectionView?.register(CustomCell.self, forCellWithReuseIdentifier: customCellIdentifier)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath)
        customCell.layer.cornerRadius = 6
        
        return customCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }


}

class CustomCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        
        label.backgroundColor = UIColor(red: 252/255, green: 237/255, blue: 244/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.numberOfLines = 0
        label.text = "Custom Text Custom Text Custom Text Custom Text Custom Text Custom Text Custom Text"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let completedRuleButton: UIButton = {
        let checkButton = UIButton()
        checkButton.backgroundColor = UIColor(red: 252/255, green: 237/255, blue: 244/255, alpha: 1)
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        return checkButton
    }()
    
    func setUpViews() {
        backgroundColor = UIColor(red: 249/255, green: 199/255, blue: 224/255, alpha: 1)
        
        addSubview(nameLabel)
        addSubview(completedRuleButton)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[v0]-[v1(44)]-4-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel, "v1": completedRuleButton]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0(44)]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0(44)]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": completedRuleButton]))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

