//
//  FCImageView.swift
//  FightCamp-Homework
//
//  Created by Oleksandr Kovalyshyn on 29.07.2020.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

class FCImageView: UIImageView {
    
    // MARK: - Properties
    
    var isSelected: Bool = false {
        didSet {
            switch isSelected {
            case true:
                self.layer.borderColor = UIColor.thumbnailBorder(selected: true).cgColor
            case false:
                self.layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureView() {
        self.isSelected = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
        self.layer.cornerRadius = .thumbnailRadius
        self.layer.borderWidth = .thumbnailBorderWidth
    }
    
    func downloadImage(fromURL url: String) {
        ImageProvider.shared.downloadImage(from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                DispatchQueue.main.async { self.image = image }
            case .failure(_):
                DispatchQueue.main.async { self.image = Images.placeholderImage }
            }
        }
    }
}
