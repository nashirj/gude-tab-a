//
//  ViewController.swift
//  tip-calculator
//
//  Created by Nashir Janmohamed on 9/5/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Tip Calculator"
        billAmountTextField.keyboardType = UIKeyboardType.decimalPad
        billAmountTextField.becomeFirstResponder()
        updateColorScheme()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateBillAmount), name: UIApplication.willEnterForegroundNotification, object: nil)
        resetFields()
        updateBillAmount()

    }
    
    func resetFields() {
        // get currency symbol
        let currencySymbol = Locale.current.currencySymbol;
        
        billAmountTextField.text = ""
        tipPercentageLabel.text = "\(currencySymbol ?? "$")0.00"
        totalLabel.text = "\(currencySymbol ?? "$")0.00"
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updateColorScheme()
    }
    
    @objc func updateBillAmount() {
        let defaults = UserDefaults.standard;
        let timeOfLastChange = defaults.object(forKey: "timeOfLastChange") ?? nil
        
        if let prevDate = timeOfLastChange {
            // compute time diff
            let time_diff = Date().timeIntervalSince(prevDate as! Date)
            
            // clear bill if its been more than 10 minutes
            if time_diff > 10 * 60 {
                resetFields()
            } else {
                let tipString = defaults.string(forKey:"tipString")
                let totalString = defaults.string(forKey:"totalString")
                let bill = defaults.string(forKey:"billAmount")
                billAmountTextField.text = bill
                tipPercentageLabel.text = tipString
                totalLabel.text = totalString
            }
        }
    }
    
    // set UserDefault vals specified in SettingsViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        tipAmountSegmentedControl.selectedSegmentIndex = defaults.integer(forKey: "defaultTipPercentage")
    }
    
    func updateColorScheme() {
        let segmentedControls: [UISegmentedControl] = [tipAmountSegmentedControl]
        let textFields: [UITextField] = [billAmountTextField]
        Helper.updateColorScheme(traitCollection: traitCollection, view: self.view, segmentedControls: segmentedControls, textFields: textFields)
    }
    
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipAmountSegmentedControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBAction func onTap(_ sender: Any) {
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billAmountTextField.text!) ?? 0
        let tipPercentages = [0.15, 0.18, 0.2]
        
        let tip = bill * tipPercentages[tipAmountSegmentedControl.selectedSegmentIndex]
        
        let total = bill + tip
        
        let tipString = NumberFormatter.localizedString(from: NSNumber(value: tip), number: NumberFormatter.Style.currency)
        let totalString = NumberFormatter.localizedString(from: NSNumber(value: total), number: NumberFormatter.Style.currency)
        
        tipPercentageLabel.text = String(format: "\(tipString)")
        totalLabel.text = String(format: "\(totalString)")
        
        let defaults = UserDefaults.standard
        var billString: String;
        if bill == 0 {
            billString = ""
        } else {
            billString = billAmountTextField.text!
        }
        defaults.set(Date(), forKey:"timeOfLastChange")
        defaults.set(tipString, forKey:"tipString")
        defaults.set(totalString, forKey:"totalString")
        defaults.set(billString, forKey:"billAmount")
        defaults.synchronize()
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

