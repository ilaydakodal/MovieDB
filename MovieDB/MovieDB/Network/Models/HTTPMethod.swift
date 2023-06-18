//
//  HTTPMethod.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 15.06.2023.
//

import Foundation

enum HTTPMethod: String, Codable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
