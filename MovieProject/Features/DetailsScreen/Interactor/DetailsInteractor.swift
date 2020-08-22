//
//  DetailsInteractor.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 12.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

protocol DetailsInteractorInput {
    func loadDetails()
    func addToFavorite()
}

final class DetailsInteractor {
    
    //MARK: - Properties
    
    var presenter: DetailsPresenterInput?
    private let movieId: Int
    private let networkService: NetworkService
    private let coreDataService: CoreDataService
    private let mapper: DetailsMapper
    private var details: MovieDetails!
    
    //MARK: - Init
    
    init(movieId: Int,
         networkService: NetworkService,
         coreDataService: CoreDataService,
         mapper: DetailsMapper) {
        self.movieId = movieId
        self.networkService = networkService
        self.coreDataService = coreDataService
        self.mapper = mapper
    }
}

//MARK: - DetailsInteractorInput
extension DetailsInteractor: DetailsInteractorInput {
    func loadDetails() {
        networkService.getDetails(by: movieId) { [weak self] response in
            guard let self = self else { return }
            let details = self.mapper.map(from: response)
            self.details = details
            let isFavorite = self.coreDataService.isFavorite(movieId: self.movieId)
            self.presenter?.detailsLoaded(details: details, isFavorite: isFavorite)
        }
    }
    
    func addToFavorite() {
        coreDataService.addFavorite(movie: details)
    }
}
