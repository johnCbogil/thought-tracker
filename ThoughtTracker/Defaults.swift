//
//  Defaults.swift
//  ThoughtTracker
//
//  Created by John Bogil on 12/14/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation
import DefaultsKit

let defaults = Defaults(userDefaults: UserDefaults.standard)
extension DefaultsKey {

    static let thoughtsKey = Key<[Thought]>("thoughtsKey")
}


