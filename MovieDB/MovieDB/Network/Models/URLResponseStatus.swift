//
//  URLResponseStatus.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 15.06.2023.
//

import Foundation

enum URLResponseStatus<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingFailed
}
