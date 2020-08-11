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
    
    // MARK: - Properties
    
    var interactor: TrendingInteractorInput?
    private var collectionView: UICollectionView!
    private var movies: [TrendingCellModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(self)"
        setupView()
        interactor?.loadTrending()
    }
    
    //MARK: - Private
    
    private func setupView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: view.bounds.width/4, height: 200)
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

// MARK: - UICollectionViewDelegate
extension TrendingViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
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
