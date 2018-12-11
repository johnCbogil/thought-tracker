//
//  ThoughtsVCEmptyState.swift
//  ThoughtTracker
//
//  Created by John Bogil on 12/10/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation
import UIKit
import Anchors

class ThoughtsVCEmptyState: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
