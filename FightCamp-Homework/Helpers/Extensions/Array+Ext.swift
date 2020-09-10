//
//  Array+Ext.swift
//  FightCamp-Homework
//
//  Created by Oleksandr Kovalyshyn on 30.07.2020.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation

extension Array where Element == NSMutableAttributedString {
    func toAttributedString() -> NSMutableAttributedString {
        return self.reduce(into: NSMutableAttributedString(), { $0.append($1) })
    }
}

extension Sequence where Iterator.Element == NSMutableAttributedString {
    func joined(with separator: NSMutableAttributedString) -> NSMutableAttributedString {
        return self.reduce(NSMutableAttributedString()) {
            if $0.length > 0 {
                $0.append(separator)
            }
            $0.append($1)
            return $0
        }
    }
    
    func joined(with separator: String = "") -> NSMutableAttributedString {
        return self.joined(with: NSMutableAttributedString(string: separator))
    }
}
