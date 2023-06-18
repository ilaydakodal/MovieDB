//
//  MainViewController.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 15.06.2023.
//

import UIKit
import SnapKit

protocol MainViewControlable: AnyObject {
    func applySnapshot(with movie: [MovieModel])
}

class MainViewController: UIViewController, MainViewControlable {
    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    var viewModel: MainViewModel?

    // MARK: - Initialisers

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setUpView()
        viewModel?.searchMovies(query: "lion") // TODO: Remove after implementing search
    }

    private lazy var containerView: UIView = .build { view in
        view.backgroundColor = .clear
    }

    private lazy var collectionView: MainCollectionView = .build()

    private func setUpView() {
        view.addSubview(containerView)
        containerView.addSubview(collectionView)
        configureConstaints()
    }

    private func configureConstaints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func applySnapshot(with movie: [MovieModel]) {
        collectionView.applySnapshot(with: movie)
    }
}
