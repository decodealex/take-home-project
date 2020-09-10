//
//  UIStackView+Ext.swift
//  FightCamp-Homework
//
//  Created by Oleksandr Kovalyshyn on 31.07.2020.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views { addArrangedSubview(view) }
    }
}
