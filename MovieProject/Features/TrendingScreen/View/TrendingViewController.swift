//
//  TrendingViewController.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 05.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

protocol TrendingViewControllerInput: AnyObject {
    func showTrending(models: [TrendingCellModel])
}

final class TrendingViewController: UIViewController {
    
    //MARK: - Constants
    
    private enum Constants {
        static let trendingTitleText = "Популярное"
        static let cellInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        static let numberOfCellInRow: CGFloat = 3
    }
    
    //MARK: - Properties
    
    var interactor: TrendingInteractorInput?
    var router: TrendingRouterInput?
    private var collectionView: UICollectionView!
    private var movies: [TrendingCellModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        interactor?.loadTrending()
    }
    
    //MARK: - Private
    
    private func setupView() {
        title = Constants.trendingTitleText
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TrendingCell.self,
                                forCellWithReuseIdentifier: "\(TrendingCell.self)")
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
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
        return UICollectionViewCell()
    }
}

//MARK: - TrendingViewControllerInput
extension TrendingViewController: TrendingViewControllerInput {
    
    func showTrending(models: [TrendingCellModel]) {
        movies = models
    }
}
