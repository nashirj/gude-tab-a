//
//  ColorHelper.swift
//  tip-calculator
//
//  Created by Nashir Janmohamed on 9/7/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func updateColorScheme(traitCollection: UITraitCollection, view: UIView, segmentedControls: [UISegmentedControl]?, textFields: [UITextField]?) {
        var bgColor: UIColor;
//        var textColor: UIColor;
        var segControlPrimaryColor: UIColor;
        var segControlSecondaryColor: UIColor;
        var textFieldColor: UIColor;
        
        if traitCollection.userInterfaceStyle == .light {
            // light mode
//            bgColor = UIColor.systemBackground;
//            textColor = UIColor.black;
            segControlPrimaryColor = UIColor.systemBackground;
            segControlSecondaryColor = UIColor.systemFill;
            textFieldColor = UIColor.systemFill;
        } else {
            // dark mode
//            bgColor = UIColor.systemTeal;
//            textColor = UIColor.systemGray;
            segControlPrimaryColor = UIColor.systemTeal;
            segControlSecondaryColor = UIColor.systemGray;
            textFieldColor = UIColor.systemGray;
        }
        
        bgColor = UIColor.systemBackground;
        
        view.backgroundColor = bgColor;
//        self.view.textColor = bgColor;
        
        if let _segmentedControls = segmentedControls {
            for segmentedControl in _segmentedControls {
                segmentedControl.tintColor = segControlPrimaryColor;
                segmentedControl.selectedSegmentTintColor = segControlPrimaryColor;
                segmentedControl.backgroundColor = segControlSecondaryColor;
            }
        }
        if let _textFields = textFields {
            for textField in _textFields {
                textField.backgroundColor = textFieldColor;
            }
        }
    }
}
