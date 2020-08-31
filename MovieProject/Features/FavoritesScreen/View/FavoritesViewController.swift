//
//  FavoritesViewController.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 21.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

protocol FavoritesViewControllerInput: AnyObject {
    func showFavorites(models: [FavoritesCellModel])
}

final class FavoritesViewController: UIViewController {
    
    //MARK: - Constants
    
    private enum Constants {
        static let cellHeight: CGFloat = 150
        static let favoritesTitle = "Избранное"
        static let descriptionFont = UIFont.systemFont(ofSize: 20, weight: .thin)
        static let defaultDescriptionText = "Добавьте понравившиеся фильмы в избранное и они будут отображаться тут"
    }
    
    //MARK: - Properties
    
    var interactor: FavoritesInteractorInput?
    var router: FavoritesRouterInput?
    
    private var tableView: UITableView!
    private var descriptionLabel: UILabel!
    
    private var cellModels = [FavoritesCellModel]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        configureTableView()
        configureDescriptionLabel()
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.loadFavorites()
    }
    
    //MARK: - Private
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: "\(FavoritesCell.self)")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = Constants.cellHeight
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.fadeOut(withDuration: 0)
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = Constants.descriptionFont
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = Constants.defaultDescriptionText
        
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            descriptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        descriptionLabel.fadeIn(withDuration: 0)
    }
    
    private func configureNavigationBar() {
        title = Constants.favoritesTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(navigateToSearch))
    }
    
    //MARK: - Action
    
    @objc private func navigateToSearch(_ sender: Any) {
        router?.navigateToSearch()
    }
}

//MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router?.navigateToDetails(of: cellModels[indexPath.item].id)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            tableView.beginUpdates()
            interactor?.removeFavorite(by: cellModels[indexPath.item].id)
            tableView.deleteRows(at: [indexPath], with: .left)
            cellModels.remove(at: indexPath.item)
            tableView.endUpdates()
            
            if cellModels.isEmpty {
                tableView.fadeOut(withDuration: 0)
                descriptionLabel.fadeIn(withDuration: 1)
            }
        }
    }
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
    
    func showFavorites(models: [FavoritesCellModel]) {
        if !models.isEmpty {
            cellModels = models
            tableView.reloadData()
            descriptionLabel.fadeOut(withDuration: 0)
            tableView.fadeIn(withDuration: 0)
        }
    }
}
