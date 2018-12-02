//
//  DateCount.swift
//  ThoughtTracker
//
//  Created by John Bogil on 12/2/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation
struct DateCount: Codable {
    var dateString: String
    var count: Int
    var date: Date  {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            return dateFormatter.date(from: dateString) ?? Date()
        }
    }
}
