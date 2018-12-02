//
//  OccurrenceCell.swift
//  ThoughtTracker
//
//  Created by John Bogil on 12/2/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation
import Anchors

class OccurrenceCell: UITableViewCell {
    // MARK: - PROPERTIES
    static let identifier = "OccurrenceCell"

    // MARK: - VIEWS
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23)
        label.textColor = .black
        return label
    }()

    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23)
        label.textColor = .black
        label.text = "0"
        return label
    }()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(dateLabel)
        self.addSubview(countLabel)
        activate(self.dateLabel.anchor.left.constant(20),
                 self.dateLabel.anchor.centerY,
                 self.countLabel.anchor.right.constant(-20),
                 self.countLabel.anchor.centerY)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
