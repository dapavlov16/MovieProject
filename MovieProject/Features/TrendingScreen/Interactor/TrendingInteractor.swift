//
//  TrendingInteractor.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 05.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import CoreGraphics

protocol TrendingInteractorInput {
    func loadNextPage()
    func changeState(to state: TrendingState)
    func updateFavorites()
    func saveContentOffset(_ offset: CGPoint)
}

enum TrendingState: Int {
    case trending = 0
    case popular = 1
}

struct PagedMovies {
    var page: Int = 1
    var totalPages: Int = 1
    var movies: [Movie] = []
    var contentOffset: CGPoint = .zero
}

final class TrendingInteractor {
    
    //MARK: - Properties
    
    var presenter: TrendingPresenterInput?
    private let networkService: NetworkServiceInput
    private let coreDataService: CoreDataServiceInput
    private let mapper: MovieMapper
    
    private var currentState: TrendingState = .trending
    private var trendingData = PagedMovies()
    private var popularData = PagedMovies()
    private var currentData: PagedMovies {
        get {
            switch currentState {
            case .trending:
                return trendingData
            case .popular:
                return popularData
            }
        }
        set {
            switch currentState {
            case .trending:
                trendingData = newValue
            case .popular:
                popularData = newValue
            }
        }
    }
    
    private var page: Int {
        get {
            return currentData.page
        }
        set {
            currentData.page = newValue
        }
    }
    private var totalPages: Int {
        get {
            return currentData.totalPages
        }
        set {
            currentData.totalPages = newValue
        }
    }
    private var movies: [Movie] {
        get {
            return currentData.movies
        }
        set {
            currentData.movies = newValue
        }
    }
    
    //MARK: - Init
    
    init(networkService: NetworkServiceInput,
         coreDataService: CoreDataServiceInput,
         mapper: MovieMapper) {
        self.networkService = networkService
        self.coreDataService = coreDataService
        self.mapper = mapper
    }
    
    //MARK: - Private
    
    private func loadData(page: Int, _ completion: @escaping (Result<MovieListDto, Error>) -> Void) {
        switch currentState {
        case .trending:
            networkService.getTrending(page: page, completion)
        case .popular:
            networkService.getPopular(page: page, completion)
        }
    }
    
    private func setFavorites(movies: [Movie]) {
        movies.forEach { $0.isFavorite = coreDataService.isFavorite(movieId: $0.id) }
    }
}

//MARK: - TrendingInteractorInput
extension TrendingInteractor: TrendingInteractorInput {
    
    func loadNextPage() {
        if page <= totalPages {
            loadData(page: page) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    let newMovies = self.mapper.map(from: response)
                    self.setFavorites(movies: newMovies)
                    self.movies.append(contentsOf: newMovies)
                    self.page += 1
                    self.presenter?.nextPageLoaded(movies: newMovies)
                case .failure: break
                }
            }
        }
    }
    
    func changeState(to state: TrendingState) {
        currentState = state
        if page == 1 && movies.isEmpty {
            loadData(page: page) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    let movies = self.mapper.map(from: response)
                    self.setFavorites(movies: movies)
                    self.movies = movies
                    self.page += 1
                    self.totalPages = response.totalPages
                    self.presenter?.stateChanged(movies: movies)
                case .failure:
                    self.presenter?.errorOccured()
                }
            }
        } else {
            setFavorites(movies: movies)
            presenter?.stateChanged(movies: movies, contentOffset: currentData.contentOffset)
        }
    }
    
    func updateFavorites() {
        for (index, movie) in movies.enumerated() {
            let isFavorite = coreDataService.isFavorite(movieId: movie.id)
            if movie.isFavorite != isFavorite {
                movie.isFavorite = isFavorite
                presenter?.updateFavoriteStatus(index: index, isFavorite: isFavorite)
            }
        }
    }
    
    func saveContentOffset(_ offset: CGPoint) {
        currentData.contentOffset = offset
    }
}
