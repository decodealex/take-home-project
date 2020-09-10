//
//  ReusableView.swift
//  FightCamp-Homework
//
//  Created by Oleksandr Kovalyshyn on 05.08.2020.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

public protocol ReusableView: class {
    static var reuseIdentifier: String { get }
}


public extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
