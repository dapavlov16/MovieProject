//
//  MovieProjectTests.swift
//  MovieProjectTests
//
//  Created by Дмитрий Павлов on 02.07.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import XCTest
@testable import MovieProject

class MovieProjectTests: XCTestCase {
    
    var networkService: NetworkServiceInput!
    var detailsMapper: DetailsMapper!
    
    override func setUp() {
        self.networkService = NetworkServiceMock()
        self.detailsMapper = DetailsMapper()
    }
    
    override func tearDown() {
        networkService = nil
        detailsMapper = nil
    }
    
    func testDetailsMapper() {
        let expectedModel = generateMovieDetails(id: 1)
        networkService.getDetails(by: 1) {
            let details = self.detailsMapper.map(from: $0)
            XCTAssertEqual(details, expectedModel)
        }
    }
    
    private func generateMovieDetails(id: Int) -> MovieDetails {
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w500/poster")
        return MovieDetails(id: id,
                            title: "title",
                            originalTitle: "originalTitle",
                            tagline: nil,
                            genres: [],
                            countries: ["Russia"],
                            runtime: 61,
                            overview: "overview",
                            releaseDate: nil,
                            rating: 10,
                            voteCount: 10,
                            posterUrl: posterUrl,
                            backdropUrl: nil)
    }
}
