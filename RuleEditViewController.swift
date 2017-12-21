//
//  RuleEditViewController.swift
//  The Kitty App
//
//  Created by Kristofer Padilla on 12/10/17.
//  Copyright © 2017 Kristofer Padilla. All rights reserved.
//

import UIKit

fileprivate var ruleText: String?
fileprivate var selectedRepeatingOption: String?
fileprivate var selectedMonthOption: String?
fileprivate var selectedDayOption: String?
fileprivate var selectedHourOption: String?
fileprivate var selectedMinuteOption: String?


//MARK: RuleEditViewController
class RuleEditViewController: UIViewController, UITextViewDelegate {
    
    var rule: Rule?
    var ruleCollectionView: RulesCollectionViewController?
    var ruleIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
        if (rule == nil) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveRule))
        } else {
         navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(editRule))
            
            editRuleView.text = rule?.text
            updateRuleText()
            
            selectedRepeatingOption = rule?.repeating
            updateRepeating()
            
            if (rule?.dueMonth != nil) {
                selectedMonthOption = rule?.dueMonth
                selectedDayOption = rule?.dueDay
                updateDueDate()
            }
            
            if (rule?.dueHour != nil) {
                selectedHourOption = rule?.dueHour
                selectedMinuteOption = rule?.dueMinute
                updateDueTime()
            }
            
        }
        
        view.backgroundColor = UIColor.blue

        
        setUpViews()
    }
    
    @objc func editRule() {
        
        updateRuleText()
        
        if (dueDateTextView.text == "None") {
            selectedMonthOption = nil
            selectedDayOption = nil
        }
        
        let text = ruleText ?? ""
        let isCompletedRule = rule?.ruleCompleted
        
        rule = Rule(text: text, dueMonth: selectedMonthOption, dueDay: selectedDayOption, dueHour: selectedHourOption, dueMinute: selectedMinuteOption, repeating: selectedRepeatingOption, ruleCompleted: isCompletedRule!)
        
        ruleCollectionView?.updateRule(rule: rule!, index: ruleIndex!)
        
        clearVars()
        dismissView()
    }
    
    @objc func saveRule() {
        
        updateRuleText()
        
        if (dueDateTextView.text == "None") {
            selectedMonthOption = nil
            selectedDayOption = nil
        }
        
        let text = ruleText ?? ""
        let isCompletedRule = false
        
        rule = Rule(text: text, dueMonth: selectedMonthOption, dueDay: selectedDayOption, dueHour: selectedHourOption, dueMinute: selectedMinuteOption, repeating: selectedRepeatingOption, ruleCompleted: isCompletedRule)
        
        ruleCollectionView?.addRule(rule: rule!)
        
        clearVars()
        dismissView()
    }
    
    func clearVars() {
        selectedRepeatingOption = nil
        selectedMinuteOption = nil
        selectedHourOption = nil
        selectedDayOption = nil
        selectedMonthOption = nil
        ruleText = nil
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {

        view.endEditing(true)
    }
    
    @objc func updateRuleText() {
        
        ruleText = editRuleView.text ?? ""
        dismissKeyboard()
    }
    
    @objc func updateRepeating () {
        if (selectedRepeatingOption != nil) {
            repeatingTextView.text = (selectedRepeatingOption ?? "Daily")
        }
        else
        {
            repeatingTextView.text = "Daily"
        }
        dismissKeyboard()
    }
    
    @objc func cancelSetRepeating() {
        
        repeatingTextView.text = "None"
        view.endEditing(true)
    }
    
    @objc func updateDueDate () {
        if (selectedMonthOption != nil || selectedMinuteOption != nil) {
            
            selectedMonthOption = (selectedMonthOption ?? "1")
            selectedDayOption = (selectedDayOption ?? "1")
            
            dueDateTextView.text =  selectedMonthOption! + "/" + selectedDayOption!
        }
        else
        {
            
            selectedMonthOption = "1"
            selectedDayOption = "1"
            
            dueDateTextView.text = "1/01"
        }
        dismissKeyboard()
    }
    
    
    
    @objc func cancelSetDueDate() {
        
        dueDateTextView.text = "None"
        view.endEditing(true)
    }
    
    @objc func updateDueTime() {
        
        if (selectedHourOption != nil || selectedMinuteOption != nil) {
            
            selectedHourOption = (selectedHourOption ?? "0")
            selectedMinuteOption = (selectedMinuteOption ?? "0")
            
            dueTimeTextView.text =  selectedHourOption! + ":" + selectedMinuteOption!
        }
        else
        {
            selectedHourOption = "0"
            selectedMinuteOption = "0"
            
            dueTimeTextView.text = "00:00"
        }
        
        dismissKeyboard()
    }
    
    @objc func cancelSetDueTime() {
        
        dueTimeTextView.text = "None"
        view.endEditing(true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        updateRuleText()
    }
    
    let ruleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.text = "Rule"
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.numberOfLines=0
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
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(RuleEditViewController.updateRuleText))
        
        toolbar.setItems([saveButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        label.inputAccessoryView = toolbar
        
        return label
    }()
    
    let repeatingLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.text = "Repeating: "
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let repeatingTextView: UITextView = {
        let label = UITextView()
        label.backgroundColor = UIColor.white
        label.text = "Daily"
        label.font = UIFont.systemFont(ofSize: 12)
        //label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(RuleEditViewController.updateRepeating))
        
        let cancelButton = UIBarButtonItem(title: "Set None", style: .plain, target: self, action: #selector(RuleEditViewController.cancelSetRepeating))
        
        toolbar.setItems([saveButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        label.inputAccessoryView = toolbar
        
        let repeatingPicker = RepeatingPicker()
        repeatingPicker.delegate = repeatingPicker
        label.inputView = repeatingPicker
        
        return label
    }()
    
    let dueDateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.text = "Next Due Date: "
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dueDateTextView: UITextView = {
        let label = UITextView()
        label.backgroundColor = UIColor.white
        label.text = "None"
        label.font = UIFont.systemFont(ofSize: 12)
        //label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(RuleEditViewController.updateDueDate))
        
        let cancelButton = UIBarButtonItem(title: "Set None", style: .plain, target: self, action: #selector(RuleEditViewController.cancelSetDueDate))
        
        toolbar.setItems([saveButton, cancelButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        label.inputAccessoryView = toolbar
        
        
        let dueDatePicker = DueDatePicker()
        dueDatePicker.delegate = dueDatePicker
        label.inputView = dueDatePicker
        
        return label
    }()
    
    let dueTimeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.text = "Due Time: "
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dueTimeTextView: UITextView = {
        let label = UITextView()
        label.backgroundColor = UIColor.white
        label.text = "None"
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(RuleEditViewController.updateDueTime))
        
        let cancelButton = UIBarButtonItem(title: "Set None", style: .plain, target: self, action: #selector(RuleEditViewController.cancelSetDueTime))
        
        toolbar.setItems([saveButton, cancelButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        label.inputAccessoryView = toolbar
        
        let dueTimePicker = DueTimePicker()
        dueTimePicker.delegate = dueTimePicker
        label.inputView = dueTimePicker
        
        return label
    }()
    
    func setUpViews() {
        view.addSubview(ruleLabel)
        view.addSubview(editRuleView)
        editRuleView.delegate = self
        
        view.addSubview(repeatingLabel)
        view.addSubview(repeatingTextView)
        
        view.addSubview(dueDateLabel)
        view.addSubview(dueDateTextView)
        
        view.addSubview(dueTimeLabel)
        view.addSubview(dueTimeTextView)
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-2-[v0]-2-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": ruleLabel]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-2-[v0]-2-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": editRuleView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-2-[v0][v1]-2-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": repeatingLabel, "v1": repeatingTextView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-2-[v0][v1]-2-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dueDateLabel, "v1": dueDateTextView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-2-[v0][v1]-2-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dueTimeLabel, "v1": dueTimeTextView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-147-[v0(35)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": repeatingLabel]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-186-[v0(35)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dueDateLabel]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-225-[v0(35)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dueTimeLabel]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v0(25)]-4-[v1(50)]-4-[v2(35)]-4-[v3(35)]-[v4(35)]-476-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":ruleLabel, "v1": editRuleView, "v2": repeatingTextView, "v3": dueDateTextView, "v4": dueTimeTextView]))
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


class DueDatePicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let monthOptions = Array(1...12)
    let dayOptions = Array(1...31)
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0
        {
            return monthOptions.count
        }
        //otherwise it is component 1
            return dayOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0
        {
            return String(describing: monthOptions[row])
        }
        //otherwise it is component 1
        return String(describing: dayOptions[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0
        {
            selectedMonthOption = String(describing: monthOptions[row])
        }
        
        //otherwise compnent 1
        else
        {
            selectedDayOption = String(describing: dayOptions[row])
        }
    }
}

class DueTimePicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let hourOptions = Array(0...23)
    let minuteOptions = Array(0...59)
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0
        {
            return hourOptions.count
        }
        //otherwise it is component 1
        return minuteOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0
        {
            return String(describing: hourOptions[row])
        }
        //otherwise it is component 1
        return String(describing: minuteOptions[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0
        {
            selectedHourOption = String(describing: hourOptions[row])
        }
        
        //otherwise compnent 1
        else
        {
            selectedMinuteOption = String(describing: minuteOptions[row])
        }
    }
}

