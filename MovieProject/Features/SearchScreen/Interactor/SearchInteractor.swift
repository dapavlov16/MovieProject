//
//  SearchInteractor.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 14.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

protocol SearchInteractorInput {
    func searchMovie(query: String)
}

final class SearchInteractor {
    
    //MARK: - Properties
    
    var presenter: SearchPresenterInput?
    private let networkService: NetworkServiceInput
    private let coreDataService: CoreDataServiceInput
    private let movieMapper: MovieMapper
    private let genresMapper: GenresMapper
    private var genres = [Genre]()
    
    //MARK: - Init
    
    init(networkService: NetworkServiceInput,
         coreDataService: CoreDataServiceInput,
         movieMapper: MovieMapper,
         genresMapper: GenresMapper) {
        
        self.networkService = networkService
        self.coreDataService = coreDataService
        self.movieMapper = movieMapper
        self.genresMapper = genresMapper
        
        loadGenres()
    }
    
    //MARK: - Private
    
    private func loadGenres() {
        if let genresList = coreDataService.getGenresList() {
            genres = genresMapper.map(from: genresList)
        } else {
            networkService.getGenres { [weak self] (genresList) in
                self?.genres = genresList.genres
                self?.coreDataService.addGenresList(genres: genresList.genres)
            }
        }
    }
}

//MARK: - SearchInteractorInput
extension SearchInteractor: SearchInteractorInput {
    
    func searchMovie(query: String) {
        networkService.searchMovie(query) { (response) in
            let result = self.movieMapper.map(from: response)
            self.presenter?.searchCompleted(movies: result, genres: self.genres)
        }
    }
}
