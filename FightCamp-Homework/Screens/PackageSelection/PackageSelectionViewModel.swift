//
//  PackageSelectionViewModel.swift
//  FightCamp-Homework
//
//  Created by Oleksandr Kovalyshyn on 30.07.2020.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation

protocol PackageSelectionViewModelDelegate: class {
    func willLoadData()
    func didLoadData()
}

protocol PackageProviderProtocol {
    func getPackages(completion: @escaping (Result<[Package], PackageProviderError>) -> Void)
}

class PackageSelectionViewModel {
    
    // MARK: - Properties
    
    private(set) var packages: [Package] = []
    private let packageProvider: PackageProviderProtocol
    weak var delegate: PackageSelectionViewModelDelegate?
    
    // MARK: - Lifecycle
    
    init(packageProvider: PackageProviderProtocol) {
        self.packageProvider = packageProvider
        self.getPackages()
    }
    
    //MARK: - Helpers
    
    private func getPackages() {
        self.delegate?.willLoadData()
        
        self.packageProvider.getPackages { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let pack):
                self.packages = pack
                self.delegate?.didLoadData()
            case .failure(_):
                break
            }
        }
    }
}
