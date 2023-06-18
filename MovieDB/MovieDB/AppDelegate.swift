//
//  AppDelegate.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 15.06.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Variables

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        let navigationController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigationController)
        coordinator?.routeToMainPage()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light

        return true
    }
}
