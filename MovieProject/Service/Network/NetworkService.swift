//
//  NetworkService.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 06.07.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

class NetworkService {
    
    private let client = TMDBClient()
    
    func searchMovie(_ text: String, _ completion: @escaping (TMDBResponse) -> Void) {
        client.request(request: .searchMovie(text: text), completion)
    }
    
    func getTrending(_ completion: @escaping (TMDBResponse) -> Void) {
        client.request(request: .getTrending, completion)
    }
    
    func getDetails(by id: Int, _ completion: @escaping (MovieDTO) -> Void) {
        client.request(request: .getDetails(id: id), completion)
    }
}
