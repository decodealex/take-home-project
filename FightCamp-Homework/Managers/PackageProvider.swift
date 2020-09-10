//
//  PackageProvider.swift
//  FightCamp-Homework
//
//  Created by Oleksandr Kovalyshyn on 31.07.2020.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation

enum PackageProviderError: Error {
    case invalidFilePath
    case unableToDecodeData
}

class PackageProvider {
    
    //MARK: - Lifecycle
    
    init() {}
    
    //MARK: - Functions
    
    func readJSONFromFile(fileName: String, completion: @escaping (Result<[Package], PackageProviderError>) -> Void) {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decoded = try decoder.decode([Package].self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(PackageProviderError.unableToDecodeData))
            }
        } else {
            completion(.failure(PackageProviderError.invalidFilePath))
        }
    }
}

extension PackageProvider: PackageProviderProtocol {
    func getPackages(completion: @escaping (Result<[Package], PackageProviderError>) -> Void) {
        self.readJSONFromFile(fileName: Constants.packagesFileName) { result in
            switch result {
            case .success(let packages):
                completion(.success(packages))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
