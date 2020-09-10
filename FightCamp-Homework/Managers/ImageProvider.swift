//
//  ImageProvider.swift
//  FightCamp-Homework
//
//  Created by Oleksandr Kovalyshyn on 31.07.2020.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

enum ImageProviderError: Error {
    case unableToConvertDataToImage
}

class ImageProvider {
    
    // MARK: - Properties
    
    static let shared = ImageProvider()
    let cache: [String: UIImage] = [:]
    
    // MARK: - Lifecycle
    
    private init() {}
    
    // MARK: - Functions
    
    func downloadImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let image = cache[urlString] {
            completion(.success(image))
            return
        }
        
        NetworkManager.shared.performRequest(urlString: urlString) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(.failure(ImageProviderError.unableToConvertDataToImage))
                    return
                }
                completion(.success(image))
            }
        }
    }
}
