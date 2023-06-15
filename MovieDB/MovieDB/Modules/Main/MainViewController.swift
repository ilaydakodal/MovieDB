//
//  MainViewController.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 15.06.2023.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Properties
    
    weak var coordinator: MainCoordinator?

    // MARK: - Initialisers

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
}
