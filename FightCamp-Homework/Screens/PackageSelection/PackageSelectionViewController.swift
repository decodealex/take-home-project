//
//  PackageSelectionViewController.swift
//  FightCamp-Homework
//
//  Created by Oleksandr Kovalyshyn on 31.07.2020.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

class PackageSelectionViewController: DataLoadingViewController {
    
    // MARK: - Properties
    
    var viewModel: PackageSelectionViewModel {
        didSet {
            viewModel.delegate = self
            self.updateTableView()
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(PackageCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = self.view.frame.height
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    init(viewModel: PackageSelectionViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.layoutViews()
    }
    
    // MARK: - Helpers
    
    private func configureView() {
        self.view.backgroundColor = .secondaryBackground
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func layoutViews() {
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: .packageSpacing),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -.packageSpacing),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func updateTableView() {
        UIView.transition(with: self.tableView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.tableView.reloadData()
        }, completion: nil)
    }
}

//MARK: - PackageSelectionViewModelDelegate

extension PackageSelectionViewController: PackageSelectionViewModelDelegate {
    func willLoadData() {
        self.showLoadingView()
    }
    
    func didLoadData() {
        self.dissmissLoadingView()
        self.updateTableView()
    }
}

//MARK: - UITableViewDataSource

extension PackageSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = PackageCellViewModel(package: viewModel.packages[indexPath.section])
        let cell: PackageCell = tableView.dequeueReusableCell(for: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.packages.count
    }
}

//MARK: - UITableViewDelegate

extension PackageSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .packageSpacing
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}

