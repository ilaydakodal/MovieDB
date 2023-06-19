//
//  MainCoordinator.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 15.06.2023.
//

import UIKit

protocol MainCoordinating {
    var navigationController: UINavigationController { get set }

    func routeToMainPage()
    func routeToDetail(with movie: MovieModel)
}

/// `Main Coordinator` is a navigation layer that injects `network layer` and `viewModels` and `userDefaultsManager` to the views.
/// - Includes:
///  - `configureNavigationBar`: To configure navigation bar for this navigation controller
///  - `routeToHomePage`: Routes home page with UserEntity object which recives from Login Response
class MainCoordinator: MainCoordinating {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemGray6
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
    }

    func routeToMainPage() {
        let networkService: NetworkManaging = NetworkManager()
        let viewModel = MainViewModel(networkService: networkService)
        let mainViewController = MainViewController()
      //  let delegate = MoviePosterCollectionViewDelegate()

        viewModel.view = mainViewController
        mainViewController.viewModel = viewModel
        mainViewController.coordinator = self
        mainViewController.delegate = mainViewController
       // mainViewController.collectionView.delegate = delegate
        navigationController.pushViewController(mainViewController, animated: true)
    }

    func routeToDetail(with movie: MovieModel) {
        let detailViewController = DetailViewController(movie: movie)
        detailViewController.coordinator = self
        navigationController.modalPresentationStyle = .pageSheet
        if let sheet = detailViewController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        navigationController.present(detailViewController, animated: true)
    }
}
