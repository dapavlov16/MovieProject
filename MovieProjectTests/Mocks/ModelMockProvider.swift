//
//  ModelMocksProvider.swift
//  MovieProjectTests
//
//  Created by Дмитрий Павлов on 28.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

@testable import MovieProject
import Foundation

final class ModelMockProvider {
    
    lazy var movieDto = MovieDto(adult: false,
                                 backdropPath: nil,
                                 budget: 100,
                                 genres: genres,
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
                                 voteCount: 10)
    
    lazy var movieDetails = MovieDetails(id: 1,
                                         title: "title",
                                         originalTitle: "originalTitle",
                                         tagline: nil,
                                         genres: genres,
                                         countries: ["Russia"],
                                         runtime: 61,
                                         overview: "overview",
                                         releaseDate: nil,
                                         rating: 10,
                                         voteCount: 10,
                                         posterUrl: URL(string: "https://image.tmdb.org/t/p/w500/poster"),
                                         backdropUrl: nil)
    
    lazy var genres: [Genre] = {
        var genres = [Genre]()
        for i in 1...3 {
            genres.append(Genre(id: i, name: "genre\(i)"))
        }
        return genres
    }()
    
    lazy var genresListDto: GenresListDto = {
        return GenresListDto(genres: genres)
    }()
}
