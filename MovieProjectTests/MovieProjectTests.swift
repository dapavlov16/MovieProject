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

    var networkService: NetworkService!
    
    override func setUp() {
        self.networkService = NetworkServiceMock()
    }
    
    func testExample() {
        
    }
}
