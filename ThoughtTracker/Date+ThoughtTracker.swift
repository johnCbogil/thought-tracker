//
//  Date+ThoughtTracker.swift
//  ThoughtTracker
//
//  Created by John Bogil on 12/2/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation

extension Date{

    func generateDatesArrayBetweenTwoDates(startDate: Date, endDate: Date) -> [Date] {
        var datesArray = [Date]()
        var startDate = startDate

        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"

        while startDate <= endDate {
            datesArray.append(startDate)
            guard let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: startDate) else { return datesArray }
            startDate = tomorrow
        }
        return datesArray
    }
}
