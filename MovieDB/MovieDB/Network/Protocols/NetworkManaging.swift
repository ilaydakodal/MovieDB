//
//  NetworkManaging.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 15.06.2023.
//

import Foundation

protocol NetworkManaging {
    func request<T: Decodable>
    (endpoint: String,
     method: HTTPMethod,
     queryParams: [String: String]?,
     headers: [String: String]?,
     completion: @escaping (Result<T, NetworkError>) -> Void)
}
