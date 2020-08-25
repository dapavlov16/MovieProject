//
//  TrendingPresenter.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 05.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

protocol TrendingPresenterInput {
    func stateChanged(movies: [Movie])
    func nextPageLoaded(movies: [Movie])
}

final class TrendingPresenter {
    
    //MARK: - Properties
    
    weak var view: TrendingViewControllerInput?
    private var formatter: TrendingCellModelFormatter
    
    //MARK: - Init
    
    init(formatter: TrendingCellModelFormatter) {
        self.formatter = formatter
    }
}

//MARK: - TrendingPresenterInput
extension TrendingPresenter: TrendingPresenterInput {
    
    func stateChanged(movies: [Movie]) {
        let models = formatter.format(from: movies)
        DispatchQueue.main.async {
            self.view?.showMovies(models: models)
        }
    }
    
    func nextPageLoaded(movies: [Movie]) {
        let models = formatter.format(from: movies)
        DispatchQueue.main.async {
            self.view?.appendNextPage(models: models)
        }
    }
}
