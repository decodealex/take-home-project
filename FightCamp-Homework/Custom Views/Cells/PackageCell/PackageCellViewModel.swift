//
//  PackageCellViewModel.swift
//  FightCamp-Homework
//
//  Created by Oleksandr Kovalyshyn on 30.07.2020.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

struct PackageCellViewModel {
    
    // MARK: - Properties
    
    private var package: Package
    
    var title: String {
        package.title.uppercased()
    }
    var description: String {
        package.desc.capitalized
    }
    var payment: String {
        package.payment.capitalized
    }
    var buttonTitle: String {
        package.action.capitalized
    }
    var price: String {
        "$\(package.price)"
    }
    var imageURLs: [String] {
        package.thumbnailUrls
    }
    var body: NSMutableAttributedString {
        let array = bodyIncluded + bodyExcluded
        return array.joined(with: "\n").addLineSpacing()
    }
    
    private var bodyIncluded: [NSMutableAttributedString] {
        
        return package.included.map({ $0.capitalized.getAttributedString() })
    }
    private var bodyExcluded: [NSMutableAttributedString] {
        package.excluded?.map({ $0.capitalized.getStrokedAttributedString(color: .disabledLabel) }) ?? []
    }
    
    // MARK: - Lifecycle
    
    init(package: Package) {
        self.package = package
    }
}

private extension NSMutableAttributedString {
    func addLineSpacing() -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = .lineHeightMultiple
        
        self.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, self.length))
        return self
    }
}
