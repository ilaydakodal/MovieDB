//
//  MainViewModel.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 16.06.2023.
//

import Foundation

// MARK: - MainViewModeling

protocol MainViewModeling {
    func searchMovies(text: String, page: Int)
}

// MARK: - MainViewModel

final class MainViewModel {

    // MARK: - Properties

    private let networkService: NetworkManaging
    weak var view: MainViewControlable?

    var movies: [MovieModel] = []
    var id: Int? = 0
    var currentPage: Int = 0
    var totalPages: Int = 0
    var errorMessage: String?

    // MARK: - Initialisers

    init(networkService: NetworkManaging) {
        self.networkService = networkService
    }

    func searchMovies(text: String, page: Int = 1) {
        view?.didStartSearch()
        let endpoint = endoints.search.path
        let queryParameters = ["query": text, "page": "\(page)"]
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNGQzOTljMTI4ZjJiOTJjYTY0ZjJlYzA4MzlmZTg3MiIsInN1YiI6IjY0OGFmNzkzNTU5ZDIyMDExYzRhOTEzOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Wx2DX_CKf_RfWDNI0EiZ8Tvf_BOsMEfFWTPLiS_gz4k"
        ] // TODO: Implement a secrets manager to hide the key

        networkService.request(
            endpoint: endpoint,
            method: HTTPMethod.get,
            queryParams: queryParameters,
            headers: headers ) { (result: Result<MovieResponse, NetworkError>) in
                switch result {
                case .success(let response):
                    self.movies = response.results
                    self.currentPage = response.page
                    self.totalPages = response.totalPages ?? 0
                    self.errorMessage = nil
                    self.applySnapshot()
                case .failure(let error):
                    self.movies = []
                    self.errorMessage = "Failed to fetch movies. Error: \(error)" // TODO: Refactor error handling
                }
                self.view?.didEndSearch()
            }
    }

    // TODO: Move to detail ViewModel
    func fetchMovieDetail(id: Int) {
        view?.didStartSearch()
        let endpoint = endoints.detail(movieId: id).path
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNGQzOTljMTI4ZjJiOTJjYTY0ZjJlYzA4MzlmZTg3MiIsInN1YiI6IjY0OGFmNzkzNTU5ZDIyMDExYzRhOTEzOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Wx2DX_CKf_RfWDNI0EiZ8Tvf_BOsMEfFWTPLiS_gz4k"
        ] // TODO: Implement a secrets manager to hide the key

        networkService.request(
            endpoint: endpoint,
            method: HTTPMethod.get,
            queryParams: nil,
            headers: headers ) { (result: Result<MovieModel, NetworkError>) in
                switch result {
                case .success(let response):
                    self.movies.append(response)
                case .failure(let error):
                    self.errorMessage = "Failed to fetch movies. Error: \(error)" // TODO: Refactor error handling
                }
                self.view?.didEndSearch()
            }
    }

    func loadMoreMovies(text: String) {
        guard currentPage < totalPages else {
            return
        }

        let nextPage = currentPage + 1
        searchMovies(text: text, page: nextPage)
    }

    func applySnapshot() {
        view?.applySnapshot(with: movies)
    }
}
