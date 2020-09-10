//
//  FCThumbnailView.swift
//  FightCamp-Homework
//
//  Created by Oleksandr Kovalyshyn on 29.07.2020.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

class FCThumbnailView: UIView {
    
    // MARK: - Properties
    
    var imageURLs: [String] = [] {
        didSet {
            self.primaryImageView.downloadImage(fromURL: imageURLs[0])
        }
    }
    
    lazy var primaryImageView: FCImageView = {
        let imageView = FCImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 0
        
        return imageView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = .thumbnailSpacing
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ThumbnailImageCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func layoutViews() {
        self.addSubviews(primaryImageView, collectionView)
        self.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            self.primaryImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.primaryImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.primaryImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.primaryImageView.heightAnchor.constraint(equalToConstant: .thumbnailHeight),
            
            self.collectionView.topAnchor.constraint(equalTo: self.primaryImageView.bottomAnchor, constant: .thumbnailSpacing),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: .thumbnailSecondaryHeight)
        ])
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension FCThumbnailView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let minimumItemSpacing: CGFloat = .thumbnailSpacing
        let width = self.bounds.width
        let availableWidth = width - (minimumItemSpacing * 3)
        let size = availableWidth / 4
        
        return CGSize(width: size, height: size)
    }
}

//MARK: - UICollectionViewDelegate

extension FCThumbnailView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.primaryImageView.downloadImage(fromURL: imageURLs[indexPath.row])
    }
}

//MARK: - UICollectionViewDataSource

extension FCThumbnailView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ThumbnailImageCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.set(imageURL: imageURLs[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
}
