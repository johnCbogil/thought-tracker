//
//  Thought.swift
//  ThoughtTracker
//
//  Created by John Bogil on 11/25/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation

class Thought: Codable {
    var count = 0
    let title: String

    init(count: Int, title: String) {
        self.count = count
        self.title = title
    }
}
