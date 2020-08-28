//
//  NetworkServiceMock.swift
//  MovieProjectTests
//
//  Created by Дмитрий Павлов on 26.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

@testable import MovieProject

final class NetworkServiceMock: NetworkServiceInput {
    
    private lazy var modelMockProvider = ModelMockProvider()
    
    func searchMovie(_ text: String, _ completion: @escaping (MovieListDto) -> Void) {
        //stub
    }
    
    func getTrending(page: Int, _ completion: @escaping (MovieListDto) -> Void) {
        //stub
    }
    
    func getPopular(page: Int, _ completion: @escaping (MovieListDto) -> Void) {
        //stub
    }
    
    func getDetails(by movieId: Int, _ completion: @escaping (MovieDto) -> Void) {
        completion(modelMockProvider.movieDto)
    }
    
    func getGenres(_ completion: @escaping (GenresListDto) -> Void) {
        completion(modelMockProvider.genresListDto)
    }
}
