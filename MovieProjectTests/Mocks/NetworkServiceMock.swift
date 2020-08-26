//
//  NetworkServiceMock.swift
//  MovieProjectTests
//
//  Created by Дмитрий Павлов on 26.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

@testable import MovieProject

final class NetworkServiceMock: NetworkServiceInput {
    
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
        //stub
    }
    
    func getGenres(_ completion: @escaping (GenresListDto) -> Void) {
        var genres = [Genre]()
        for i in 1...10 {
            genres.append(Genre(id: i, name: "genre\(i)"))
        }
        completion(GenresListDto(genres: genres))
    }
}
