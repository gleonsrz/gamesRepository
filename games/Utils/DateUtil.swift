//
//  DateUtil.swift
//  games
//
//  Created by Christian Leon on 18/07/23.
//

import Foundation

class DateUtil {
    static func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: date)
        }
        
        return ""
    }
}
