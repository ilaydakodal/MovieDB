//
//  DetailModel.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 19.06.2023.
//

import Foundation

// MARK: - DetailModel

struct DetailModel: Codable {
    let id: Int
    let backdropPath: String?
    let genres: [Genre]?
    let overview, releaseDate: String?
    let runtime: Int?
    let title: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, id, overview
        case releaseDate = "release_date"
        case runtime, title
        case voteAverage = "vote_average"
    }
}

// MARK: - Genre

struct Genre: Codable {
    let id: Int?
    let name: String?
}
