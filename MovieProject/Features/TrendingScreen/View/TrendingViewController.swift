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
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        interactor?.loadTrending()
    }
    
    //MARK: - Private
    
    private func setupView() {
        
    }
}

// MARK: - UICollectionViewDelegate
extension TrendingViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension TrendingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}

//MARK: - TrendingViewControllerInput
extension TrendingViewController: TrendingViewControllerInput {
    
    func showTrending(models: [TrendingCellModel]) {
        // TODO
    }
}
