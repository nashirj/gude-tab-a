//
//  SettingsViewController.swift
//  tip-calculator
//
//  Created by Nashir Janmohamed on 9/7/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateColorScheme()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updateColorScheme()
    }
    
    @IBOutlet weak var defaultTipAmountSegmentedControl: UISegmentedControl!
    
    func updateColorScheme() {
        let segmentedControls: [UISegmentedControl] = [defaultTipAmountSegmentedControl]
        Helper.updateColorScheme(traitCollection: traitCollection, view: self.view, segmentedControls: segmentedControls, textFields: nil)
    }
    
    // set UserDefault vals specified in SettingsViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard;
        defaultTipAmountSegmentedControl.selectedSegmentIndex = defaults.integer(forKey: "defaultTipPercentage");
    }
    
    @IBAction func setDefaultTipPercentage(_ sender: Any) {
        let defaults = UserDefaults.standard;
        defaults.set(defaultTipAmountSegmentedControl.selectedSegmentIndex, forKey: "defaultTipPercentage");
        
        defaults.synchronize()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
