//
//  PackageCell.swift
//  FightCamp-Homework
//
//  Created by Oleksandr Kovalyshyn on 29.07.2020.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

class PackageCell: UITableViewCell {
    
    // MARK: - Properties
    
    var viewModel: PackageCellViewModel! {
        didSet {
            self.configureSubviews()
        }
    }
    
    private let titleLabel = UILabel().configurePrimaryLabel(textAlignment: .left, font: .title, textColor: .brandRed)
    private let paymentLabel = UILabel().configurePrimaryLabel(textAlignment: .center, font: .body, textColor: .label)
    private let priceLabel = UILabel().configurePrimaryLabel(textAlignment: .center, font: .price, textColor: .label)
    private let thumbNailView = FCThumbnailView()
    
    private let descriptionLabel = UILabel {
        $0.numberOfLines = 2
    }.configurePrimaryLabel(textAlignment: .left, font: .body, textColor: .label)
    
    private let bodyLabel = UILabel {
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }.configurePrimaryLabel(textAlignment: .left, font: .body, textColor: .label)
    
    private var paymentStackView = UIStackView {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.spacing = .thumbnailSpacing
    }
    
    private var mainStackView = UIStackView {
        $0.axis = .vertical
        $0.spacing = .packageSpacing
        $0.distribution = .equalSpacing
        $0.alignment = .fill
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let button = UIButton {
        $0.layer.cornerRadius = .buttonRadius
        $0.titleLabel?.font = .button
        $0.setTitleColor(.buttonTitle, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .buttonBackground
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "FCPackageCell")
        
        self.configureView()
        self.layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func layoutViews() {
        self.addSubview(mainStackView)
        self.paymentStackView.addArrangedSubviews(self.paymentLabel, self.priceLabel)
        self.mainStackView.addArrangedSubviews(self.titleLabel, self.descriptionLabel, self.thumbNailView, self.bodyLabel, self.paymentStackView, self.button)
        
        NSLayoutConstraint.activate([
            self.button.heightAnchor.constraint(equalToConstant: .buttonHeight),
            
            self.mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: .packageSpacing),
            self.mainStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: .packageSpacing),
            self.mainStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -.packageSpacing),
            self.mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -.packageSpacing)
        ])
    }
    
    private func configureSubviews() {
        self.thumbNailView.imageURLs = viewModel.imageURLs
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
        self.bodyLabel.attributedText = viewModel.body
        self.paymentLabel.text = viewModel.payment
        self.priceLabel.text = viewModel.price
        self.button.setTitle(viewModel.buttonTitle, for: .normal)
    }
    
    private func configureView() {
        self.backgroundColor = .primaryBackground
        self.layer.cornerRadius = .packageRadius
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbNailView.primaryImageView.image = nil
    }
}

//MARK: - Extensions

extension PackageCell: ReusableView {}

extension UILabel {
    func configurePrimaryLabel(textAlignment: NSTextAlignment, font: UIFont, textColor: UIColor) -> UILabel {
        self.textAlignment = textAlignment
        self.font = font
        self.textColor = textColor
        self.translatesAutoresizingMaskIntoConstraints = false
        
        return self
    }
}
