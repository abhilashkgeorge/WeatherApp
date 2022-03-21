//
//  UILabel + Ext.swift
//  WeatherApp
//
//  Created by Abhilash k George on 20/03/22.
//

import Foundation
import UIKit

extension UILabel {
    func addCharacterSpacing(spacingValue: Double = 2.0) {
        guard let text = text, !text.isEmpty else { return }
        let string = NSMutableAttributedString(string: text)
        string.addAttribute(NSAttributedString.Key.kern, value: spacingValue, range: NSRange(location: 0, length: string.length - 1))
        attributedText = string
    }
    
    
}
