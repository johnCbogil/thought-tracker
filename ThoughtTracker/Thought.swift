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
    var formattedOccurrences = [DateCount]()
    let title: String

    init(date: Date, title: String) {
        self.title = title

//        // FOR TESTING
//        let testDate = Date(timeIntervalSinceNow: -370000)
//        self.listOfOccurrences.append(testDate)

        self.formattedOccurrences.append(contentsOf: getFormattedOccurrences())
    }

    func getFormattedOccurrences() -> [DateCount] {

        var datesBetweenArray = [Date]()
        let sortedOccurrences = self.listOfOccurrences.sorted(by: { $0.compare($1) == .orderedAscending })
        if let firstDate = sortedOccurrences.first {
            datesBetweenArray = Date().generateDatesArrayBetweenTwoDates(startDate: firstDate , endDate: Date())
            datesBetweenArray.append(contentsOf: self.listOfOccurrences)
        }

        // CREATE A DICT OF DATES AND COUNTS
        let dateCounts = datesBetweenArray.reduce(into: [String: Int]()) { dict, date in
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            let key = formatter.string(from: date)
            dict[key, default: 0] += 1
        }

        // BREAK DICT INTO ARRAY OF OBJECTS
        var array = [DateCount]()
        for (date, count) in dateCounts {
            let dateCountStruct = DateCount(dateString: date, count: count-1)
            array.append(dateCountStruct)
        }

        // SORT ARRAY BY DATE
        array.sort(by: { $0.date > $1.date })

        return array
    }
}


