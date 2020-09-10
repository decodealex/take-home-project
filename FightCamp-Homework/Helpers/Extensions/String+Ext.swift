//
//  String+Ext.swift
//  FightCamp-Homework
//
//  Created by Oleksandr Kovalyshyn on 30.07.2020.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

extension String {
    func getAttributedString() -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
    
    func getStrokedAttributedString(color: UIColor) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .strikethroughStyle: NSUnderlineStyle.thick.rawValue,
            .strokeColor: color
        ]
        
        let string = NSMutableAttributedString(string: self, attributes: attributes)
        
        return string
    }
}
