//
//  TrendingViewController.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 05.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

protocol TrendingViewControllerInput: AnyObject {
    func showMovies(models: [TrendingCellModel], contentOffset: CGPoint)
    func appendNextPage(models: [TrendingCellModel])
    func updateFavoriteStatus(index: Int, isFavorite: Bool)
    func showErrorDescription()
}

final class TrendingViewController: UIViewController {
    
    //MARK: - Constants
    
    private enum Constants {
        static let trendingTitleText = "В тренде"
        static let popularTitleText = "Популярное"
        static let cellInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        static let numberOfCellInRow: CGFloat = 3
        static let paginationOffset = 7
        static let errorDescriptionFont = UIFont.systemFont(ofSize: 20, weight: .thin)
        static let defaultErrorText = "Что-то пошло не так..."
    }
    
    //MARK: - Properties
    
    var interactor: TrendingInteractorInput?
    var router: TrendingRouterInput?
    
    private var collectionView: UICollectionView!
    private var segmentedControl: UISegmentedControl!
    private var activityIndicator: UIActivityIndicatorView!
    private var errorDescriptionLabel: UILabel!
    
    private var movies: [TrendingCellModel] = []
    private var isLoading = false
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureNavigationItem()
        configureActivityIndicator()
        configureDescriptionLabel()
        configureCollectionView()
        changeState(to: .trending)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.updateFavorites()
    }
    
    //MARK: - Private
    
    private func configureNavigationItem() {
        segmentedControl = UISegmentedControl(items: [
            Constants.trendingTitleText,
            Constants.popularTitleText
        ])
        segmentedControl.selectedSegmentIndex = TrendingState.trending.rawValue
        segmentedControl.addTarget(self,
                                   action: #selector(segmentedControlAction),
                                   for: .valueChanged)
        navigationItem.titleView = segmentedControl
    }
    
    private func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }
    
    private func configureDescriptionLabel() {
        errorDescriptionLabel = UILabel()
        errorDescriptionLabel.numberOfLines = 0
        errorDescriptionLabel.textAlignment = .center
        errorDescriptionLabel.font = Constants.errorDescriptionFont
        errorDescriptionLabel.text = Constants.defaultErrorText
        
        view.addSubview(errorDescriptionLabel)
        errorDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            errorDescriptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TrendingCell.self,
                                forCellWithReuseIdentifier: "\(TrendingCell.self)")
        
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func changeState(to state: TrendingState) {
        errorDescriptionLabel.fadeOut(withDuration: 0)
        collectionView.fadeOut(withDuration: 0)
        activityIndicator.startAnimating()
        interactor?.changeState(to: state)
    }
    
    //MARK: - Actions
    
    @objc private func segmentedControlAction(_ sender: Any) {
        let state = TrendingState(rawValue: segmentedControl.selectedSegmentIndex)
        interactor?.saveContentOffset(collectionView.contentOffset)
        changeState(to: state ?? .trending)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension TrendingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellXInsetsSum = Constants.cellInsets.left + Constants.cellInsets.right
        let width = UIScreen.main.bounds.width/Constants.numberOfCellInRow - cellXInsetsSum
        let height = width*2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.cellInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.navigateToDetails(of: movies[indexPath.item].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if !isLoading && movies.count - Constants.paginationOffset < indexPath.item {
            isLoading = true
            interactor?.loadNextPage()
        }
    }
}

//MARK: - UICollectionViewDataSource
extension TrendingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TrendingCell.self)", for: indexPath) as? TrendingCell {
            
            cell.viewModel = movies[indexPath.item]
            return cell
        }
        return TrendingCell()
    }
}

//MARK: - TrendingViewControllerInput
extension TrendingViewController: TrendingViewControllerInput {
    
    func showMovies(models: [TrendingCellModel], contentOffset: CGPoint) {
        movies = models
        collectionView.reloadData()
        if contentOffset.y > 0 {
            collectionView.setContentOffset(contentOffset, animated: false)
        } else {
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .bottom, animated: false)
        }
        collectionView.fadeIn(withDuration: 0.7) { completed in
            self.activityIndicator.stopAnimating()
        }
        isLoading = false
    }
    
    func appendNextPage(models: [TrendingCellModel]) {
        let startIndex = movies.count
        let indexPaths = Array(startIndex..<startIndex + models.count).map {
            IndexPath(item: $0, section: 0)
        }
        movies.append(contentsOf: models)
        collectionView.insertItems(at: indexPaths)
        isLoading = false
    }
    
    func updateFavoriteStatus(index: Int, isFavorite: Bool) {
        movies[index].isFavorite = isFavorite
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.reloadItems(at: [indexPath])
    }
    
    func showErrorDescription() {
        activityIndicator.stopAnimating()
        errorDescriptionLabel.fadeIn(withDuration: 1)
        isLoading = false
    }
}
