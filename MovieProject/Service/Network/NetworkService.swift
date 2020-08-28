//
//  NetworkService.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 06.07.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

protocol NetworkServiceInput {
    func searchMovie(_ text: String, _ completion: @escaping (MovieListDto) -> Void) -> URLSessionDataTask?
    func getTrending(page: Int, _ completion: @escaping (MovieListDto) -> Void)
    func getPopular(page: Int, _ completion: @escaping (MovieListDto) -> Void)
    func getDetails(by movieId: Int, _ completion: @escaping (MovieDto) -> Void)
    func getGenres(_ completion: @escaping (GenresListDto) -> Void)
}

final class NetworkService {
    
    private let client = TMDBClient()
}

//MARK: - NetworkServiceInput
extension NetworkService: NetworkServiceInput {
    
    func searchMovie(_ text: String, _ completion: @escaping (MovieListDto) -> Void) -> URLSessionDataTask? {
        return client.request(request: .searchMovie(text: text), completion)
    }
    
    func getTrending(page: Int, _ completion: @escaping (MovieListDto) -> Void) {
        client.request(request: .getTrending(page: page), completion)
    }
    
    func getPopular(page: Int, _ completion: @escaping (MovieListDto) -> Void) {
        client.request(request: .getPopular(page: page), completion)
    }
    
    func getDetails(by movieId: Int, _ completion: @escaping (MovieDto) -> Void) {
        client.request(request: .getDetails(id: movieId), completion)
    }
    
    func getGenres(_ completion: @escaping (GenresListDto) -> Void) {
        client.request(request: .getGenres, completion)
    }
}
