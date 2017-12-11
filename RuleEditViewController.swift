//
//  RuleEditViewController.swift
//  The Kitty App
//
//  Created by Kristofer Padilla on 12/10/17.
//  Copyright © 2017 Kristofer Padilla. All rights reserved.
//

import UIKit

var selectedRepeatingOption = "Daily"

class RuleEditViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blue
        
        setUpViews()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard() {
        repeatingTextView.text = "Repeating: " + selectedRepeatingOption
        view.endEditing(true)
    }
    
    let ruleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.text = "Rule"
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let editRuleView: UITextView = {
        let label = UITextView()
        label.backgroundColor = UIColor(red: 252/255, green: 237/255, blue: 244/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit() //multi-line?
        label.isScrollEnabled = false
        label.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //fills view to edges
        //label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(RuleEditViewController.dismissKeyboard))
        
        toolbar.setItems([saveButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        label.inputAccessoryView = toolbar
        
        return label
    }()
    
    let repeatingTextView: UITextView = {
        let label = UITextView()
        label.backgroundColor = UIColor.white
        label.text = "Repeating: Daily"
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(RuleEditViewController.dismissKeyboard))
        
        toolbar.setItems([saveButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        label.inputAccessoryView = toolbar
        
        return label
    }()
    
    let dueDateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.text = "Rule"
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpViews() {
        view.addSubview(ruleLabel)
        view.addSubview(editRuleView)
        view.addSubview(repeatingTextView)
        
        let repeatingPicker = RepeatingPicker()
        repeatingPicker.delegate = repeatingPicker
        repeatingTextView.inputView = repeatingPicker
//        repeatingTextView.text = "Repeating: Daily"
        
        
        
        
        
        view.addSubview(dueDateLabel)
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[v0]-4-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": ruleLabel]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[v0]-4-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": editRuleView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[v0]-4-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": repeatingTextView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[v0]-4-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dueDateLabel]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0]-8-[v1(50)]-[v2(35)]-[v3(10)]-450-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":ruleLabel, "v1": editRuleView, "v2": repeatingTextView, "v3": dueDateLabel]))
    }

}

class RepeatingPicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let repeatingOptions = ["Daily", "weekly", "monthly"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return repeatingOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return repeatingOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRepeatingOption = repeatingOptions[row]
    }
}
