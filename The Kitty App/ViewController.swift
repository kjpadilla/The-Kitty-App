	//
//  ViewController.swift
//  The Kitty App
//
//  Created by Kristofer Padilla on 10/23/17.
//  Copyright © 2017 Kristofer Padilla. All rights reserved.
//

import UIKit
    
var RuleButtonCount = 0

class RulesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout	{

    let customCellIdentifier = "customCellIdentifier"
    let theRulesArr = [
    "Brush your teeth first thing when you wake up, or eat and then brush",
    "Review the rules and what you have to do for the day",
    "Drink a glass of water daily",
    "Always wear your collar when you go out (unless you are wearing a neck accessory for the aesthetic)",
    "Art Monday - Friday for 1 hour, (half an hour on workdays longer than 4 hours)",
    "Bedtime is 7 hours before you have to get up",
    "Try on your retainer once a month and adjust rule from there (11/30)",
    "Wash your face every night (night showers count)",
    "Brush your teeth before you go to sleep",
    "Kneel whenever we either of us are coming to stay in the apartment",
    "Work out every two weeks (11/22)",
    "Do two courses of Duolingo everyday"
    ]
    
    @objc func completedRuleButtonPressed (_ sender: UIButton!) {
        print("button pressed " + String(sender.tag))
        if (sender.backgroundImage(for: .normal) == #imageLiteral(resourceName: "kittyPaw")) {
            UserDefaults.standard.set(false, forKey: "clickedRuleButton" + String(sender.tag))
            UserDefaults.standard.synchronize()
            sender.setBackgroundImage(nil, for: .normal)
        }
        else {
            UserDefaults.standard.set(true, forKey: "clickedRuleButton" + String(sender.tag))
            UserDefaults.standard.synchronize()
            sender.setBackgroundImage(#imageLiteral(resourceName: "kittyPaw"), for: .normal)
        }
    }
    
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
        
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as! CustomCell
        customCell.layer.cornerRadius = 6
        
        customCell.ruleLabel.text = theRulesArr[indexPath.item]
        
        customCell.completedRuleButton.addTarget(self, action: #selector(completedRuleButtonPressed), for: .touchUpInside)
        
        return customCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }


}

class CustomCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("cell created ")
        setUpViews()
    }
    
    let ruleLabel: UILabel = {
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
        RuleButtonCount = RuleButtonCount + 1
        checkButton.tag = RuleButtonCount
        if (UserDefaults.standard.bool(forKey: "clickedRuleButton" + String(checkButton.tag))) {
            checkButton.setBackgroundImage(#imageLiteral(resourceName: "kittyPaw"), for: .normal)
        }
        return checkButton
    }()
    
    func setUpViews() {
        backgroundColor = UIColor(red: 249/255, green: 199/255, blue: 224/255, alpha: 1)
        
        addSubview(ruleLabel)
        addSubview(completedRuleButton)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[v0]-[v1(44)]-4-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": ruleLabel, "v1": completedRuleButton]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0(44)]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": ruleLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0(44)]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": completedRuleButton]))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

