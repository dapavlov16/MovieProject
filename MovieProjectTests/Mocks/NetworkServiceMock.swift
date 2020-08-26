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
        completion(MovieDto(adult: false,
                            backdropPath: nil,
                            budget: 100,
                            genres: [],
                            homepage: nil,
                            id: 1,
                            imdb_id: nil,
                            originalLanguage: "ru",
                            originalTitle: "originalTitle",
                            overview: "overview",
                            posterPath: "/poster",
                            productionCountries: [ProductionCountry(iso: "ru", name: "Russia")],
                            releaseDate: nil,
                            revenue: 100,
                            runtime: 61,
                            status: "",
                            tagline: nil,
                            title: "title",
                            voteAverage: 10,
                            voteCount: 10))
    }
    
    func getGenres(_ completion: @escaping (GenresListDto) -> Void) {
        var genres = [Genre]()
        for i in 1...10 {
            genres.append(Genre(id: i, name: "genre\(i)"))
        }
        completion(GenresListDto(genres: genres))
    }
}
