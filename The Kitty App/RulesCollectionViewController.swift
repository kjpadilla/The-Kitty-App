	//
//  ViewController.swift
//  The Kitty App
//
//  Created by Kristofer Padilla on 10/23/17.
//  Copyright © 2017 Kristofer Padilla. All rights reserved.
//

import UIKit
    
var RuleLoadedCount = 0
var RuleCountTotal = 0
    
    var theRulesArr = UserDefaults.standard.object(forKey: "theRulesArray") != nil ? UserDefaults.standard.array(forKey: "theRulesArray") as! [String] :  [
    "Brush your teeth first thing when you wake up, or eat and then brush",
    "Review the rules and what you have to do for the day",
    "Drink a glass of water daily",
    "Always wear your collar when you go out (unless you are wearing a neck accessory for the aesthetic)",
    "Art Monday - Friday for 1 hour (half an hour on workdays longer than 4 hours)",
    "Bedtime is 7 hours before you have to get up",
    "Try on your retainer once a month and adjust rule from there (11/30)",
    "Wash your face every night (night showers count)",
    "Brush your teeth before you go to sleep",
    "Kneel whenever we either of us are coming to stay in the apartment",
    "Work out every two weeks (11/22)",
    "Do two courses of Duolingo everyday"
]

class RulesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextViewDelegate	{

    
    let customCellIdentifier = "customCellIdentifier"
    
    var currentTextView: UITextView? = nil
    
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
        
//        collectionView?.backgroundColor = UIColor(red: 252/255, green: 237/255, blue: 244/255, alpha: 1)
        
        collectionView?.backgroundColor = UIColor(red: 249/255, green: 199/255, blue: 224/255, alpha: 1)
        
        collectionView?.register(CustomCell.self, forCellWithReuseIdentifier: customCellIdentifier)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRule))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(removeOrEditRule))
        
        UserDefaults.standard.set(theRulesArr, forKey: "theRulesArray")
        UserDefaults.standard.synchronize()
    
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @objc func addRule (sender: UIBarButtonItem) {
        print("add rule")
        
        theRulesArr.append("New Rule")
        
        UserDefaults.standard.set(theRulesArr, forKey: "theRulesArray")
        UserDefaults.standard.synchronize()
        
        let insertionPathindex = NSIndexPath(item: theRulesArr.count-1, section: 0)
        collectionView?.insertItems(at: [insertionPathindex as IndexPath])
        
        collectionView?.scrollToItem(at: insertionPathindex as IndexPath, at: .bottom, animated: true)
        
    }
    
    @objc func removeOrEditRule (sender: UIBarButtonItem) {
        print("Remove or edit")
    }
    
    
    @objc func removeKeyboard (sender: UIBarButtonItem) {
        print("remove the keyboard")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRule))
        currentTextView?.resignFirstResponder()
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(removeKeyboard))
        currentTextView = textView
        print("begin edit")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("EndEditing at tag: " + String(textView.tag))
        
        theRulesArr[textView.tag] = textView.text
        print(textView.text + " for tag " + String(textView.tag))
        UserDefaults.standard.set(theRulesArr, forKey: "theRulesArray")
        UserDefaults.standard.synchronize()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return theRulesArr.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as! CustomCell
        
        customCell.ruleLabel.text = theRulesArr[indexPath.item]
        customCell.ruleLabel.tag = indexPath.item
        
        customCell.ruleLabel.delegate = self
        
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
    
    let ruleLabel: UITextView = {
        let label = UITextView()
        label.layer.cornerRadius = 6
        label.backgroundColor = UIColor(red: 252/255, green: 237/255, blue: 244/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.isScrollEnabled = false
        label.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //label.numberOfLines = 0
        
    
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let completedRuleButton: UIButton = {
        let checkButton = UIButton()
        checkButton.layer.cornerRadius = 6
        checkButton.backgroundColor = UIColor(red: 252/255, green: 237/255, blue: 244/255, alpha: 1)
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.tag = RuleLoadedCount
        if (UserDefaults.standard.bool(forKey: "clickedRuleButton" + String(checkButton.tag))) {
            checkButton.setBackgroundImage(#imageLiteral(resourceName: "kittyPaw"), for: .normal)
        }
        return checkButton
    }()
    
    func setUpViews() {
        //backgroundColor = UIColor(red: 249/255, green: 199/255, blue: 224/255, alpha: 1)
        //backgroundColor = UIColor.black
        RuleLoadedCount = RuleLoadedCount + 1
        
        addSubview(ruleLabel)
        addSubview(completedRuleButton)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]-[v1(48)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": ruleLabel, "v1": completedRuleButton]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[v0(48)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": ruleLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[v0(48)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": completedRuleButton]))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
    
    class Rule {
        var text: String
        var dueMonth: String?
        var dueDay: String?
        var repeating: String?
        var ruleCompleted: Bool
        
        init(text: String, dueMonth: String?, dueDay: String?, repeating: String?, ruleCompleted: Bool) {
            self.text = text
            self.dueMonth = dueMonth
            self.dueDay = dueDay
            self.repeating = repeating
            self.ruleCompleted = ruleCompleted
        }
        
        
    }
