//
//  EmptyStateView.swift
//  FightCamp-Homework
//
//  Created by Oleksandr Kovalyshyn on 31.07.2020.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {
    
    // MARK: - Properties
    
    let messageLabel = UILabel().configurePrimaryLabel(textAlignment: .center, font: UIFont.boldSystemFont(ofSize: 28), textColor: .label)
    let logoImageView = UIImageView()
    
    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        self.messageLabel.text = message
    }
    
    // MARK: - Helpers
    
    private func configure() {
        self.addSubviews(self.messageLabel, self.logoImageView)
        self.configureMessageLabel()
        self.configureLogoImageView()
    }
    
    private func configureMessageLabel() {
        self.messageLabel.numberOfLines = 3
        self.messageLabel.textColor = .secondaryLabel
        
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -150
        
        NSLayoutConstraint.activate([
            self.messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant),
            self.messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            self.messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            self.messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func configureLogoImageView() {
        self.logoImageView.image = Images.placeholderImage
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let logoBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40
        
        NSLayoutConstraint.activate([
            self.logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant),
            self.logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            self.logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            self.logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170)
        ])
    }
}
