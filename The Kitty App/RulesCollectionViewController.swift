	//
//  ViewController.swift
//  The Kitty App
//
//  Created by Kristofer Padilla on 10/23/17.
//  Copyright © 2017 Kristofer Padilla. All rights reserved.
//

import UIKit
    
    var theRulesArr = [
    Rule(text: "Review the rules and what you have to do for the day", dueMonth: nil,dueDay: nil,dueHour: nil,dueMinute: nil,repeating: "Daily", ruleCompleted: false),
    Rule(text: "Brush your teeth first thing when you wake up, or eat and then brush", dueMonth: nil,dueDay: nil,dueHour: nil,dueMinute: nil,repeating: "Daily", ruleCompleted: false),
    Rule(text: "No desserts for breakfast", dueMonth: nil,dueDay: nil,dueHour: nil,dueMinute: nil,repeating: nil, ruleCompleted: false),
    Rule(text: "Drink a glass of water Daily", dueMonth: nil,dueDay: nil,dueHour: nil,dueMinute: nil,repeating: "Daily", ruleCompleted: false),
    Rule(text: "Always wear your collar when you go out (unless you are wearing a neck accessory)", dueMonth: nil,dueDay: nil,dueHour: nil,dueMinute: nil,repeating: "Daily", ruleCompleted: false),
    Rule(text: "Art Monday - Friday for 1 hour", dueMonth: nil,dueDay: nil,dueHour: nil,dueMinute: nil,repeating: "Daily", ruleCompleted: false),
    Rule(text: "Bedtime is 7 hours before you have to get up", dueMonth: nil,dueDay: nil,dueHour: nil,dueMinute: nil,repeating: "Daily", ruleCompleted: false),
    Rule(text: "Try your retainer on once a month", dueMonth: "1",dueDay: "3",dueHour: nil,dueMinute: nil,repeating: "Daily", ruleCompleted: false),
    Rule(text: "Brush your teeth before bedtime", dueMonth: nil,dueDay: nil,dueHour: nil,dueMinute: nil,repeating: "Weekly", ruleCompleted: false),
    Rule(text: "Work out every two weeks", dueMonth: "12",dueDay: "20",dueHour: nil,dueMinute: nil,repeating: nil, ruleCompleted: false),
    Rule(text: "Do two courses of Duoling everyday", dueMonth: nil,dueDay: nil,dueHour: nil,dueMinute: nil,repeating: "Daily", ruleCompleted: false)
]

class RulesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextViewDelegate	{

    
    let customCellIdentifier = "customCellIdentifier"
    
    var currentTextView: UITextView? = nil
    
    @objc func completedRuleButtonPressed (_ sender: UIButton!) {
        print("button pressed " + String(sender.tag))
        if (sender.backgroundImage(for: .normal) == #imageLiteral(resourceName: "kittyPaw")) {
            theRulesArr[sender.tag].ruleCompleted = false
            sender.setBackgroundImage(nil, for: .normal)
        }
        else {
            theRulesArr[sender.tag].ruleCompleted = true
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

    
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @objc func addRule (sender: UIBarButtonItem) {
        print("add rule")
        
        theRulesArr.append(Rule(text: "New Rule", dueMonth: nil, dueDay: nil, dueHour: nil, dueMinute: nil, repeating: "Daily", ruleCompleted: false))
        
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
        
        theRulesArr[textView.tag].text = textView.text
        print(textView.text + " for tag " + String(textView.tag))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return theRulesArr.count
    }
    
    //MARK: Cell Deque
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as! CustomCell
        
        let currentRule = theRulesArr[indexPath.item]
        
        customCell.ruleLabel.text = currentRule.text
        
        if currentRule.dueMonth != nil
        {
            customCell.ruleLabel.text = customCell.ruleLabel.text + currentRule.dueMonth! + "/" + currentRule.dueDay!
        }
        
        if currentRule.dueHour != nil
        {
            customCell.ruleLabel.text = customCell.ruleLabel.text + currentRule.dueHour! + ":" + currentRule.dueMinute!
            //TODO: getFormmattedTime(hour, minute)
        }
        
        
        customCell.ruleLabel.tag = indexPath.item
        customCell.completedRuleButton.tag = indexPath.item
        
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
        if (theRulesArr[checkButton.tag].ruleCompleted == true)
        {
            checkButton.setBackgroundImage(#imageLiteral(resourceName: "kittyPaw"), for: .normal)
        }
        return checkButton
    }()
    
    func setUpViews() {
        //backgroundColor = UIColor(red: 249/255, green: 199/255, blue: 224/255, alpha: 1)
        //backgroundColor = UIColor.black
        
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
    var dueHour: String?
    var dueMinute: String?
    var repeating: String?
    var ruleCompleted: Bool
        
    init(text: String, dueMonth: String?, dueDay: String?, dueHour: String?, dueMinute: String?, repeating: String?, ruleCompleted: Bool) {
        self.text = text
        self.dueMonth = dueMonth
        self.dueDay = dueDay
        self.dueHour = dueHour
        self.dueMinute = dueMinute
        self.repeating = repeating
        self.ruleCompleted = ruleCompleted
    }
}
