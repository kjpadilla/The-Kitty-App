//
//  RuleEditViewController.swift
//  The Kitty App
//
//  Created by Kristofer Padilla on 12/10/17.
//  Copyright © 2017 Kristofer Padilla. All rights reserved.
//

import UIKit

fileprivate var selectedRepeatingOption = "Daily"
fileprivate var selectedMonthOption: String?
fileprivate var selectedDayOption: String?
fileprivate var selectedHourOption: String?
fileprivate var selectedMinuteOption: String?


//MARK: RuleEditViewController
class RuleEditViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blue
        
        setUpViews()
    }
    
    @objc func dismissKeyboard() {
        repeatingTextView.text = selectedRepeatingOption
        view.endEditing(true)
    }
    
    @objc func updateDueDate () {
        if (selectedMonthOption != nil || selectedMinuteOption != nil) {
            dueDateTextView.text = (selectedMonthOption ?? "1") + "/" + (selectedDayOption ?? "1")
        }
        else
        {
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
            dueTimeTextView.text = (selectedHourOption ?? "0") + ":" + (selectedMinuteOption ?? "0")
        }
        else
        {
            dueTimeTextView.text = "00:00"
        }
        
        dismissKeyboard()
    }
    
    @objc func cancelSetDueTime() {
        
        dueTimeTextView.text = "None"
        view.endEditing(true)
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
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(RuleEditViewController.dismissKeyboard))
        
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
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(RuleEditViewController.dismissKeyboard))
        
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
        
        view.addSubview(repeatingLabel)
        view.addSubview(repeatingTextView)
        
        view.addSubview(dueDateLabel)
        view.addSubview(dueDateTextView)
        
        view.addSubview(dueTimeLabel)
        view.addSubview(dueTimeTextView)
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[v0]-4-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": ruleLabel]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[v0]-4-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": editRuleView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[v0][v1]-4-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": repeatingLabel, "v1": repeatingTextView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[v0][v1]-4-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dueDateLabel, "v1": dueDateTextView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[v0][v1]-4-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dueTimeLabel, "v1": dueTimeTextView]))
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

