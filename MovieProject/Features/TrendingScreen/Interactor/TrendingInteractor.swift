//
//  TrendingInteractor.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 05.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

protocol TrendingInteractorInput {
    func loadTrending()
}

final class TrendingInteractor {
    
    //MARK: - Properties
    
    var presenter: TrendingPresenterInput?
    private let networkService: NetworkService
    private let mapper: MovieMapper
    
    //MARK: - Init
    
    init(networkService: NetworkService, mapper: MovieMapper) {
        self.networkService = networkService
        self.mapper = mapper
    }

}

//MARK: - TrendingInteractorInput
extension TrendingInteractor: TrendingInteractorInput {
    
    func loadTrending() {
        networkService.getTrending { response in
            let movies = self.mapper.map(from: response)
            self.presenter?.trendingLoaded(movies: movies)
        }
    }
}
