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
    var todaysCount: Int {
        get {
            var count = 0
            for date in self.listOfOccurrences {
                if Calendar.current.compare(date, to: Date(), toGranularity: .day) == .orderedSame {
                    count += 1
                }
            }
            return count
        }
    }

    init(date: Date, title: String) {
        self.title = title

                // FOR TESTING
                let testDate = Date(timeIntervalSinceNow: -570000)
                self.listOfOccurrences.append(testDate)
        
        self.formattedOccurrences.append(contentsOf: getFormattedOccurrences())
    }

    func getFormattedOccurrences() -> [DateCount] {

        // GENERATE LIST OF DATES BETWEEN FIRST DATE AND TODAY
        var datesBetweenArray = [Date]()
        let sortedOccurrences = self.listOfOccurrences.sorted(by: { $0.compare($1) == .orderedAscending })
        if let firstDate = sortedOccurrences.first {
            datesBetweenArray = Date().generateDatesArrayBetweenTwoDates(startDate: firstDate , endDate: Date())
        }

        // CREATE A DICT OF DATES AND COUNTS FROM DATESBETWEENARRAY WITH COUNTS OF ZERO
        let dateCountsBetween = datesBetweenArray.reduce(into: [String: Int]()) { dict, date in
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            let key = formatter.string(from: date)
            dict[key, default: 0] = 0
        }
        
        // CREATE A DICT OF DATES AND COUNTS FROM LISTOFOCCURRENCES WITH ACCURATE DATE COUNTS
        let dateCountsOccurrences = self.listOfOccurrences.reduce(into: [String: Int]()) { dict, date in
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            let key = formatter.string(from: date)
            dict[key, default: 0] += 1
        }

        // CHANGE EMPTY DATES INTO DATECOUNTS
        var emptyDateCountArray = [DateCount]()
        for (date, count) in dateCountsBetween {
            let dateCountStruct = DateCount(dateString: date, count: count)
            emptyDateCountArray.append(dateCountStruct)
        }
        
        // CHANGE ACTUAL DATES INTO DATECOUNTS
        var actualDateCountsArray = [DateCount]()
        for (date, count) in dateCountsOccurrences {
            let dateCountStruct = DateCount(dateString: date, count: count)
            actualDateCountsArray.append(dateCountStruct)
        }
        
        // MERGE BOTH DATECOUNT ARRAYS
        actualDateCountsArray.append(contentsOf: emptyDateCountArray)

        // SORT ARRAY BY DATE
        actualDateCountsArray.sort(by: { $0.date > $1.date })

        return actualDateCountsArray
    }
}
