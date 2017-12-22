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

class RulesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate	{

    
    private func saveRules() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(theRulesArr, toFile: Rule.ArchiveUrl.path)
//        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: theRulesArr), forKey: "rules")
//        UserDefaults.standard.synchronize()
        if isSuccessfulSave {
            print("successful SAVE!!!!!")
        } else {
            print("failed to save")
        }
    }
    
    let customCellIdentifier = "customCellIdentifier"
    
    var currentTextView: UITextView? = nil
    
    @objc func completedRuleButtonPressed (_ sender: UIButton!) {
        print("button pressed " + String(sender.tag))
        if (sender.backgroundImage(for: .normal) == #imageLiteral(resourceName: "kittyPaw")) {
            theRulesArr[sender.tag].ruleCompleted = false
            saveRules()
            sender.setBackgroundImage(nil, for: .normal)
        }
        else {
            theRulesArr[sender.tag].ruleCompleted = true
            print("for index \(sender.tag) the value is \(theRulesArr[sender.tag].ruleCompleted)")
            saveRules()
            sender.setBackgroundImage(#imageLiteral(resourceName: "kittyPaw"), for: .normal)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "The Rules"
        
//        collectionView?.backgroundColor = UIColor(red: 252/255, green: 237/255, blue: 244/255, alpha: 1)
        
        collectionView?.backgroundColor = UIColor(red: 249/255, green: 199/255, blue: 224/255, alpha: 1)
        
        collectionView?.register(CustomCell.self, forCellWithReuseIdentifier: customCellIdentifier)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentEditRuleView))
//        if let decoded = UserDefaults.standard.object(forKey: "rules") {
//            loadRules()
//        }
        
        if let savedRules = loadRules() {
            theRulesArr = savedRules
            for rules in savedRules {
                print(rules.ruleCompleted)
            }
        } else {
            print("do something if nothing was loaded")
        }
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(deleteRulesView))
        
        print("Collection VUEW LOADED")

    
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func deleteRulesView() {
        
        print("DELETE RULES VIEW CALLED")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(endDeleting))
        
        for row in 0..<(collectionView?.numberOfItems(inSection: 0))! {
            print(row)
            
            let indexPath = IndexPath(item: row, section: 0)
            
            let cell = collectionView?.cellForItem(at: indexPath) as! CustomCell
            
            cell.completedRuleButton.removeTarget(self, action: #selector(completedRuleButtonPressed), for: .touchUpInside)
            cell.completedRuleButton.addTarget(self, action: #selector(deleteRule), for: .touchUpInside)
            print("deleteOne")
            cell.completedRuleButton.setBackgroundImage(#imageLiteral(resourceName: "deleteIcon"), for: .normal)
            
        }
    }
    
    
    @objc func endDeleting() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(deleteRulesView))
        
        for row in 0..<(collectionView?.numberOfItems(inSection: 0))! {
            print(row)
            print("removing Target")
            
            let indexPath = IndexPath(item: row, section: 0)
            
            let cell = collectionView?.cellForItem(at: indexPath) as! CustomCell
            
            cell.completedRuleButton.removeTarget(self, action: #selector(deleteRule), for: .touchUpInside)
            cell.completedRuleButton.addTarget(self, action: #selector(completedRuleButtonPressed), for: .touchUpInside)
            
            if theRulesArr[row].ruleCompleted == true {
                cell.completedRuleButton.setBackgroundImage(#imageLiteral(resourceName: "kittyPaw"), for: .normal)
            }
            else {
                cell.completedRuleButton.setBackgroundImage(nil, for: .normal)
            }
            
            
        }
        

    }
    
    @objc func deleteRule(sender: UIButton) {
        print(sender.tag)
        
        let index = sender.tag
        
        theRulesArr.remove(at: sender.tag)
        saveRules()
        
        collectionView?.deleteItems(at: [IndexPath(item: sender.tag, section: 0)])
        
        for row in index..<(collectionView?.numberOfItems(inSection: 0))! {
            print(row)
            
            let indexPath = IndexPath(item: row, section: 0)
            
            let cell = collectionView?.cellForItem(at: indexPath) as! CustomCell
            
            cell.completedRuleButton.tag = cell.completedRuleButton.tag - 1
            cell.ruleLabel.tag = cell.ruleLabel.tag - 1
            
        }
        
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item selected at " + String(indexPath.item))
    }
    
    
    @objc func presentEditRuleView () {
        print("add rules")
        
        let addRuleViewController = RuleEditViewController()
        addRuleViewController.ruleCollectionView = self
        //navigationController?.pushViewController(addRuleViewController, animated: true)
        //self.present(addRuleViewController, animated: true, completion: nil)
        let addRuleViewNav = UINavigationController(rootViewController: addRuleViewController)
        
        
        navigationController?.present(addRuleViewNav, animated: true, completion: nil)
//        theRulesArr.append(Rule(text: "New Rule", dueMonth: nil, dueDay: nil, dueHour: nil, dueMinute: nil, repeating: "Daily", ruleCompleted: false))
//
//        let insertionPathindex = NSIndexPath(item: theRulesArr.count-1, section: 0)
//        collectionView?.insertItems(at: [insertionPathindex as IndexPath])
//
//        collectionView?.scrollToItem(at: insertionPathindex as IndexPath, at: .bottom, animated: true)
        
    }
    
    func addRule(rule: Rule) {
        
        let insertionIndexPath = IndexPath(item: theRulesArr.count, section: 0)
        
        theRulesArr.append(rule)
        collectionView?.insertItems(at: [insertionIndexPath])
        saveRules()
        
//        let newIndexPath = IndexPath(item: theRulesArr.count, section: 0)
//        let cell = collectionView?.cellForItem(at: newIndexPath) as! CustomCell
//        cell.completedRuleButton.removeTarget(self, action: #selector(deleteRule(sender:)), for: .touchUpInside)
//        if(theRulesArr[newIndexPath.item].ruleCompleted == true) {
//            cell.completedRuleButton.setBackgroundImage(#imageLiteral(resourceName: "kittyPaw"), for: .normal)
//        }
//        cell.completedRuleButton.setBackgroundImage(nil, for: .normal)

        //collectionView?.scrollToItem(at: insertionIndexPath, at: .bottom, animated: true)
        
    }
    
    @objc func editRule(sender: UIGestureRecognizer) {
        
        print("editRule" + String(describing: sender.view?.tag))
        
        let addRuleViewController = RuleEditViewController()
        addRuleViewController.ruleCollectionView = self
        addRuleViewController.rule = theRulesArr[(sender.view?.tag)!]
        addRuleViewController.ruleIndex = (sender.view?.tag)!
        
        let addRuleViewNav = UINavigationController(rootViewController: addRuleViewController)
        
        
        navigationController?.present(addRuleViewNav, animated: true, completion: nil)
        
    }
    
    func updateRule(rule: Rule, index: Int) {
        theRulesArr[index] = rule
        collectionView?.reloadItems(at: [IndexPath(item: index, section: 0)])
        saveRules()

    }
    
    @objc func testPrint() {
        print("testing")
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return theRulesArr.count
    }
    
    //MARK: Cell Deque
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("CELL DEQUE")
        
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as! CustomCell
        
        let currentRule = theRulesArr[indexPath.item]
        
        customCell.ruleLabel.text = currentRule.text
        
        if currentRule.dueMonth != nil
        {
            customCell.ruleLabel.text = customCell.ruleLabel.text! + " " + currentRule.dueMonth! + "/" + currentRule.dueDay!
        }
        
        if currentRule.dueHour != nil
        {
            customCell.ruleLabel.text = customCell.ruleLabel.text! + " " + currentRule.dueHour! + ":" + currentRule.dueMinute!
            //TODO: getFormmattedTime(hour, minute)
        }
        
        
        customCell.ruleLabel.tag = indexPath.item
        let tap = UITapGestureRecognizer(target: self, action: #selector(editRule))
        tap.delegate = self
        customCell.ruleLabel.addGestureRecognizer(tap)
        //customCell.ruleLabel.addTarget(self, action: #selector(editRule), for: .touchUpInside)
        
        
        customCell.completedRuleButton.tag = indexPath.item
        customCell.completedRuleButton.removeTarget(self, action: #selector(deleteRule(sender:)), for: .touchUpInside)
        
        customCell.completedRuleButton.addTarget(self, action: #selector(completedRuleButtonPressed), for: .touchUpInside)
        
        if (theRulesArr[indexPath.item].ruleCompleted == true) {
            customCell.completedRuleButton.setBackgroundImage(#imageLiteral(resourceName: "kittyPaw"), for: .normal)
        } else {
            customCell.completedRuleButton.setBackgroundImage(nil, for: .normal)
        }
        
        return customCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }

    private func loadRules() -> [Rule]? {
//        let decoded = UserDefaults.standard.object(forKey: "rules") as! Data
//        let decodedRules = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Rule]
//        print(decodedRules.count)
//        theRulesArr = decodedRules
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: Rule.ArchiveUrl.path) as? [Rule]
        
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
        label.isEditable = false
        
        //let tap = UITapGestureRecognizer(target: self(), action: tes)        //label.numberOfLines = 0
        
    
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
        print("adding RULES TO THE SUBVIEW")
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]-[v1(48)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": ruleLabel, "v1": completedRuleButton]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[v0(48)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": ruleLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[v0(48)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": completedRuleButton]))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
    
    class Rule: NSObject, NSCoding {
        
    var text: String
    var dueMonth: String?
    var dueDay: String?
    var dueHour: String?
    var dueMinute: String?
    var repeating: String?
    var ruleCompleted: Bool
    
    struct PropertyKey {
        static let text = "text"
        static let dueMonth = "dueMonth"
        static let dueDay = "dueDay"
        static let dueHour = "dueHour"
        static let dueMinute = "dueMinute"
        static let repeating = "reapeating"
        static let ruleCompleted = "ruleCompleted"
    }
        
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveUrl = DocumentsDirectory.appendingPathComponent("rules")
    
    init(text: String, dueMonth: String?, dueDay: String?, dueHour: String?, dueMinute: String?, repeating: String?, ruleCompleted: Bool) {
        self.text = text
        self.dueMonth = dueMonth
        self.dueDay = dueDay
        self.dueHour = dueHour
        self.dueMinute = dueMinute
        self.repeating = repeating
        self.ruleCompleted = ruleCompleted
    }
        
        func encode(with aCoder: NSCoder) {
            aCoder.encode(self.text, forKey: PropertyKey.text)
            aCoder.encode(self.dueMonth, forKey: PropertyKey.dueMonth)
            aCoder.encode(self.dueDay, forKey: PropertyKey.dueDay)
            aCoder.encode(self.dueHour, forKey: PropertyKey.dueHour)
            aCoder.encode(self.dueMinute, forKey: PropertyKey.dueMinute)
            aCoder.encode(self.repeating, forKey: PropertyKey.repeating)
            aCoder.encode(self.ruleCompleted, forKey: PropertyKey.ruleCompleted)
        }
        
        required convenience init?(coder aDecoder: NSCoder) {
            
            guard let text = aDecoder.decodeObject(forKey: PropertyKey.text) as? String else {
                print("FAILURE TEXT")
                return nil
            }
            let dueMonth = aDecoder.decodeObject(forKey: PropertyKey.dueMonth) as? String
            let dueDay = aDecoder.decodeObject(forKey: PropertyKey.dueDay) as? String
            let dueHour = aDecoder.decodeObject(forKey: PropertyKey.dueHour) as? String
            let dueMinute = aDecoder.decodeObject(forKey: PropertyKey.dueMinute) as? String
            let repeating = aDecoder.decodeObject(forKey: PropertyKey.repeating) as? String
            let ruleIsCompleted = aDecoder.decodeBool(forKey: PropertyKey.ruleCompleted)
            
            self.init(text: text, dueMonth: dueMonth, dueDay: dueDay, dueHour: dueHour, dueMinute: dueMinute, repeating: repeating, ruleCompleted: ruleIsCompleted)
        }
}
