//
//  File.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 13.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

final class DetailsFormatter {

    private lazy var dateFormatter = DateFormatter()
    
    func format(from details: MovieDetails) -> DetailsModel {
        
        let calendar = Calendar.current
        let year = calendar.component(.year, from: details.releaseDate)
        let titleDescription = details.originalTitle.appending(" (\(year))")
        
        var tagline: String?
        if let tag = details.tagline, !tag.isEmpty, let first = tag.first {
            tagline = first.isLetter ? "«\(tag)»" : tag
        }
        
        let genresString = details.genres.joined(separator: ", ")
        
        let runtime = "\(details.runtime / 60):\(details.runtime % 60)"
        var countries = details.countries
        countries.append(runtime)
        let countriesRuntimeString = countries.joined(separator: ", ")
        
        dateFormatter.dateStyle = .long
        let releaseDateString = dateFormatter.string(from: details.releaseDate)
        
        return DetailsModel(title: details.title,
                            titleDescription: titleDescription,
                            tagline: tagline,
                            genresString: genresString,
                            countriesRuntimeString: countriesRuntimeString,
                            overview: details.overview,
                            releaseDateString: releaseDateString,
                            posterUrl: details.posterUrl,
                            backdropUrl: details.backdropUrl)
    }
}
