//
//  MovieModel.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 15.06.2023.
//

import Foundation

// MARK: - MovieModel

struct MovieModel: Codable {
    let id: Int
    let backdropPath: String?
    let genreIds: [Int]
    let overview: String
    let posterPath: String
    let releaseDate: String?
    let title: String?
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}

// MARK: Hashable

extension MovieModel: Hashable {
    public static func == (lhs: MovieModel, rhs: MovieModel) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
