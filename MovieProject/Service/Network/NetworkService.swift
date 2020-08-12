//
//  NetworkService.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 06.07.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

class NetworkService {
    
    private let client = TMDBClient()
    
    func searchMovie(_ text: String, _ completion: @escaping (MovieListDto) -> Void) {
        client.request(request: .searchMovie(text: text), completion)
    }
    
    func getTrending(_ completion: @escaping (MovieListDto) -> Void) {
        client.request(request: .getTrending, completion)
    }
    
    func getDetails(by movieId: Int, _ completion: @escaping (MovieDto) -> Void) {
        client.request(request: .getDetails(id: movieId), completion)
    }
}
