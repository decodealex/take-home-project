//
//  ThumbnailImageCell.swift
//  FightCamp-Homework
//
//  Created by Oleksandr Kovalyshyn on 29.07.2020.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

class ThumbnailImageCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let imageView = FCImageView {
        $0.contentMode = .scaleAspectFill
    }
    
    override var isSelected: Bool {
        didSet {
            self.imageView.isSelected = isSelected
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func set(imageURL: String) {
        self.imageView.downloadImage(fromURL: imageURL)
    }
    
    private func configureView() {
        self.addSubview(self.imageView)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.pinToEdges(of: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}

//MARK: - Extensions

extension ThumbnailImageCell: ReusableView {}
