//
//  NetworkManager.swift
//  FightCamp-Homework
//
//  Created by Oleksandr Kovalyshyn on 29.07.2020.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation

enum NetworkManagerError: Error {
    case urlSessionError(Error)
    case invalidResponse
    case invalidData
    case invalidURL
}

class NetworkManager {
    
    static var shared = NetworkManager()
    
    // MARK: - Lifecycle
    
    private init() {}
    
    // MARK: - Functions
    
    func performRequest(urlString: String, completion: @escaping (Result<Data, NetworkManagerError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard self != nil else { return }
            
            if let error = error {
                completion(.failure(.urlSessionError(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
