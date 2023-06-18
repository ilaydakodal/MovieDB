//
//  String+Extensions.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 16.06.2023.
//

import UIKit

extension String {
    func extractYearFromDateString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return String(year)
        }
        
        return nil
    }
}
