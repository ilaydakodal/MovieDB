//
//  DetailViewController.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 18.06.2023.
//

import UIKit

final class DetailViewController: UIViewController {

    // MARK: - Properties

    weak var coordinator: MainCoordinator?
    private let movie: MovieModel
    
    // MARK: - Initialisers

    init(movie: MovieModel) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    // MARK: -  View

    private lazy var detailView: DetailView = .build()

    private func setUpUI() {
        view.addSubview(detailView)
        configureConstraints()
        detailView.configureView(with: movie)
        view.backgroundColor = UIColor(named: "darkBackground")?.withAlphaComponent(0.9) // TODO: Remove constants
    }

    private func configureConstraints() {
        detailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
