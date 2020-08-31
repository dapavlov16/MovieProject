//
//  SearchInteractor.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 14.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

protocol SearchInteractorInput {
    func searchMovie(query: String)
    func loadNextPage()
}

final class SearchInteractor {
    
    //MARK: - Properties
    
    var presenter: SearchPresenterInput?
    private let networkService: NetworkServiceInput
    private let coreDataService: CoreDataServiceInput
    private let movieMapper: MovieMapper
    private let genresMapper: GenresMapper
    private var genres = [Genre]()
    private var nextPage = 1
    private var totalPages = 1
    private var currentQuery: String!
    private var currentDataTask: URLSessionDataTask?
    
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
            networkService.getGenres { [weak self] result in
                switch result {
                case .success(let genresList):
                    self?.genres = genresList.genres
                    self?.coreDataService.addGenresList(genres: genresList.genres)
                case .failure: break
                }
            }
        }
    }
}

//MARK: - SearchInteractorInput
extension SearchInteractor: SearchInteractorInput {
    
    func searchMovie(query: String) {
        currentQuery = query
        currentDataTask?.cancel()
        currentDataTask = networkService.searchMovie(query, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let searchResult = self.movieMapper.map(from: response)
                self.totalPages = response.totalPages
                self.nextPage = response.page + 1
                self.presenter?.searchCompleted(movies: searchResult, genres: self.genres)
            case .failure: break
            }
        }
    }
    
    func loadNextPage() {
        if nextPage <= totalPages {
            currentDataTask?.cancel()
            currentDataTask = networkService.searchMovie(currentQuery, page: nextPage) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    let searchResult = self.movieMapper.map(from: response)
                    self.totalPages = response.totalPages
                    self.nextPage = response.page + 1
                    self.presenter?.nextPageLoaded(movies: searchResult, genres: self.genres)
                case .failure: break
                }
            }
        }
    }
}
