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
    var modelMockProvider: ModelMockProvider!
    
    override func setUp() {
        self.networkService = NetworkServiceMock()
        self.detailsMapper = DetailsMapper()
        self.modelMockProvider = ModelMockProvider()
    }
    
    override func tearDown() {
        networkService = nil
        detailsMapper = nil
        modelMockProvider = nil
    }
    
    func testDetailsMapper() {
        let expectedModel = generateMovieDetails(id: 1)
        networkService.getDetails(by: 1) {
            let details = self.detailsMapper.map(from: $0)
            XCTAssertEqual(details, expectedModel)
        }
    }
    
    private func generateMovieDetails(id: Int) -> MovieDetails {
        return modelMockProvider.movieDetails
    }
}
