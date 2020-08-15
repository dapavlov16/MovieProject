//
//  SearchInteractor.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 14.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

protocol SearchInteractorInput {
    
}

final class SearchInteractor {
    
    //MARK: - Properties
    
    var presenter: SearchPresenterInput?
    private let networkService: NetworkService
    private let mapper: MovieMapper
    private var genres = [Genre]()
    
    //MARK: - Init
    
    init(networkService: NetworkService, mapper: MovieMapper) {
        self.networkService = networkService
        self.mapper = mapper
        loadGenres()
    }
    
    //MARK: - Private
    
    private func loadGenres() {
        networkService.getGenres { (genresList) in
            self.genres = genresList.genres
        }
    }
}

//MARK: - SearchInteractorInput
extension SearchInteractor: SearchInteractorInput {
    
}
