//
//  Endpoints.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 15.06.2023.
//

import Foundation

enum endoints {
    case search
    case detail(movieId: Int)

    var value: String {
        switch self {
        case .search:
            /// hRps://developers.themoviedb.org/3/search/search-movies
            return  "/3/search/movie"
        case .detail(let movieId):
            /// hRps://developers.themoviedb.org/3/movies/get-movie-details
            return "/3/movie/\(movieId)"
        }
    }

    var path: String {
        switch self {
        default:
            return "" + value
        }
    }
}
