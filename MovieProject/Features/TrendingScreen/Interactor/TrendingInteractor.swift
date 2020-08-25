//
//  TrendingInteractor.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 05.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

protocol TrendingInteractorInput {
    func loadNextPage()
    func changeState(to state: TrendingState)
}

enum TrendingState: Int {
    case trending = 0
    case popular = 1
}

struct PagedMovies {
    var page: Int = 1
    var totalPages: Int = 1
    var movies: [Movie] = []
}

final class TrendingInteractor {
    
    //MARK: - Properties
    
    var presenter: TrendingPresenterInput?
    private let networkService: NetworkService
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
    
    init(networkService: NetworkService, mapper: MovieMapper) {
        self.networkService = networkService
        self.mapper = mapper
    }
    
    //MARK: - Private
    
    private func loadData(page: Int, _ completion: @escaping (MovieListDto) -> Void) {
        switch currentState {
        case .trending:
            networkService.getTrending(page: page, completion)
        case .popular:
            networkService.getPopular(page: page, completion)
        }
    }
}

//MARK: - TrendingInteractorInput
extension TrendingInteractor: TrendingInteractorInput {
    
    func loadNextPage() {
        if page <= totalPages {
            loadData(page: page) { [weak self] response in
                guard let self = self else { return }
                let newMovies = self.mapper.map(from: response)
                self.movies.append(contentsOf: newMovies)
                self.page += 1
                self.presenter?.nextPageLoaded(movies: newMovies)
            }
        }
    }
    
    func changeState(to state: TrendingState) {
        currentState = state
        if page == 1 && movies.isEmpty {
            loadData(page: page) { [weak self] response in
                guard let self = self else { return }
                let movies = self.mapper.map(from: response)
                self.movies = movies
                self.page += 1
                self.totalPages = response.totalPages
                self.presenter?.stateChanged(movies: movies)
            }
        } else {
            presenter?.stateChanged(movies: movies)
        }
    }
}
