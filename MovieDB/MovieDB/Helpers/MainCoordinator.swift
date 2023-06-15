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
        let mainViewController = MainViewController()
        mainViewController.coordinator = self
        navigationController.pushViewController(mainViewController, animated: true)
    }
}
