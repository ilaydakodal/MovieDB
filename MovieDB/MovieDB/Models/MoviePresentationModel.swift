//
//  MoviePresentationModel.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 19.06.2023.
//

import Foundation

struct MoviePresentationModel {
    let id: Int
    let title: String?
    let posterPath: String?
    let backdropPath: String?
    let genres: String?
    let overview: String?
    let releaseDate: String?
    let runtime: Int?
    let voteAverage: Double?

    // MARK: Lifecycle

    init(movie: MovieModel?, detail: DetailModel) {
        self.id = movie?.id ?? .zero
        self.title = movie?.title
        self.posterPath = movie?.posterPath
        self.backdropPath = movie?.backdropPath
        self.genres = detail.genres?.first?.name
        self.overview = movie?.overview
        self.releaseDate = movie?.releaseDate
        self.runtime = movie?.runtime
        self.voteAverage = movie?.voteAverage
    }
}
