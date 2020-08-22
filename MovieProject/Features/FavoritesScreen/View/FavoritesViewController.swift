//
//  FavoritesViewController.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 21.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

protocol FavoritesViewControllerInput: AnyObject {
    
}

final class FavoritesViewController: UIViewController {
    
    //MARK: - Properties
    
    var interactor: FavoritesInteractorInput?
    var router: FavoritesRouterInput?
    
    private var tableView: UITableView!
    private var cellModels = [FavoritesCellModel]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Избранное"
        configureTableView()
    }
    
    //MARK: - Private
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: "\(FavoritesCell.self)")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

//MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "\(FavoritesCell.self)", for: indexPath) as? FavoritesCell {
            cell.viewModel = cellModels[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
}

//MARK: - FavoritesViewControllerInput
extension FavoritesViewController: FavoritesViewControllerInput {
    
}
