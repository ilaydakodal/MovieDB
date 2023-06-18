//
//  NetworkManager.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 15.06.2023.
//

import Foundation

class NetworkManager: NetworkManaging {
    private let baseURL = "https://api.themoviedb.org"

    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        queryParams: [String: String]? = nil,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void) {

        let urlString = baseURL + endpoint

        guard var urlComponents = URLComponents(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        if let queryParams = queryParams {
            urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        if let headers = headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed))
                print(">>>>>>>>>\(error)")
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }

            guard (200...299).contains(response.statusCode) else {
                completion(.failure(.requestFailed))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let messages = try decoder.decode(T.self, from: data)
                print(messages as Any)
                completion(.success(messages))
            } catch DecodingError.dataCorrupted(let context) {
                print(context)
            } catch DecodingError.keyNotFound(let key, let context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.valueNotFound(let value, let context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.typeMismatch(let type, let context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }.resume()
        }
}
