//
//  Date+Utils.swift
//  Bankey
//
//  Created by HanaTI on 2022/10/06.
//

import Foundation

extension Date {
    var monthDayYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: self)
    }
}
