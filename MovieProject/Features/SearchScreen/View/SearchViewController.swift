//
//  SearchViewController.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 14.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

protocol SearchViewControllerInput: AnyObject {
    func showSearchResult(models: [SearchCellModel])
}

final class SearchViewController: UIViewController {
    
    //MARK: - Constants
    
    private enum Constants {
        static let cellHeight: CGFloat = 150
    }
    //MARK: - Properties
    
    var interactor: SearchInteractorInput?
    var movies = [SearchCellModel]()
    private var searchController: UISearchController!
    private var tableView: UITableView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureSearchController()
        configureTableView()
    }
    
    //MARK: - Private
    
    private func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.tableHeaderView = searchController.searchBar
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchCell.self, forCellReuseIdentifier: "\(SearchCell.self)")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

//MARK: - SearchViewControllerInput
extension SearchViewController: SearchViewControllerInput {
    func showSearchResult(models: [SearchCellModel]) {
        movies = models
        tableView.reloadData()
    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO route to details
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "\(SearchCell.self)", for: indexPath) as? SearchCell {
            cell.viewModel = movies[indexPath.item]
            return cell
        }
        
        return UITableViewCell()
    }
}

//MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if query.count > 2 {
            interactor?.searchMovie(query: query)
        }
    }
}
