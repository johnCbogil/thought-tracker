//
//  Thought.swift
//  ThoughtTracker
//
//  Created by John Bogil on 11/25/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation

class Thought: Codable {
    var listOfOccurrences = [Date]()
    let title: String

    init(date: Date, title: String) {
        self.listOfOccurrences.append(date)
        self.title = title
    }

    func getFormattedOccurrences() -> [DateCount] {

        // CREATE A DICT OF DATES AND COUNTS
        let dateCounts = self.listOfOccurrences.reduce(into: [String: Int]()) { dict, date in
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            let key = formatter.string(from: date)
            dict[key, default: 0] += 1
        }

        // BREAK DICT INTO ARRAY OF OBJECTS
        var array = [DateCount]()
        for (date, count) in dateCounts {
            let dateCountStruct = DateCount.init(dateString: date, count: count)
            array.append(dateCountStruct)
        }

        // SORT ARRAY BY DATE
        array.sort(by: { $0.dateString.compare($1.dateString) == .orderedDescending })

        return array
    }
}
