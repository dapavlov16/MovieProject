//
//  SearchPresenter.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 14.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

protocol SearchPresenterInput {
    func searchCompleted(movies: [Movie], genres: [Genre])
    func nextPageLoaded(movies: [Movie], genres: [Genre])
}

final class SearchPresenter {
    
    //MARK: - Properties
    
    weak var view: SearchViewControllerInput?
    private let formatter: SearchFormatter
    
    //MARK: - Init
    
    init(formatter: SearchFormatter) {
        self.formatter = formatter
    }
}

//MARK: - SearchPresenterInput
extension SearchPresenter: SearchPresenterInput {
    
    func searchCompleted(movies: [Movie], genres: [Genre]) {
        let models = formatter.format(movies: movies, genresList: genres)
        DispatchQueue.main.async {
            self.view?.showSearchResult(models: models)
        }
    }
    
    func nextPageLoaded(movies: [Movie], genres: [Genre]) {
        let models = formatter.format(movies: movies, genresList: genres)
        DispatchQueue.main.async {
            self.view?.appendNextPage(models: models)
        }
    }
}
