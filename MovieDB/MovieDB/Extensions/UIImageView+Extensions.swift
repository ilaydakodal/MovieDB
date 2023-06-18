//
//  UIImageView+Extensions.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 18.06.2023.
//

import UIKit

extension UIImageView {
    func setImage(from urlString: String, placeholder: UIImage? = nil) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/" + urlString) else {
            self.image = placeholder
            return
        }

        self.image = placeholder

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let imageData = data, let image = UIImage(data: imageData) else { return }

            DispatchQueue.main.async {
                self?.image = image
            }
        }

        task.resume()
    }
}
