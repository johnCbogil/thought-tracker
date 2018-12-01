//
//  ThoughtCell.swift
//  ThoughtTracker
//
//  Created by John Bogil on 11/25/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation
import UIKit
import Anchors

class ThoughtCell: UITableViewCell {
    // MARK: - PROPERTIES
    static let identifier = "ThoughtCell"
    weak var delegate: ListOfThoughtsTableViewDelegate?
    var thought: Thought?

    // MARK: - VIEWS
    lazy var titleLabel: UILabel = {
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

    private lazy var rightSwipeGestureRecognizer: UISwipeGestureRecognizer = {
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ThoughtCell.incrementThoughtCount))
        gestureRecognizer.direction = .right
        return gestureRecognizer
    }()

    private lazy var leftSwipeGestureRecognizer: UISwipeGestureRecognizer = {
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ThoughtCell.decrementThoughtCount))
        gestureRecognizer.direction = .left
        return gestureRecognizer
    }()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(self.rightSwipeGestureRecognizer)
        self.addGestureRecognizer(self.leftSwipeGestureRecognizer)
        self.addSubview(titleLabel)
        self.addSubview(countLabel)
        activate(self.titleLabel.anchor.left.constant(20),
                 self.titleLabel.anchor.centerY,
                 self.countLabel.anchor.right.constant(-20),
                 self.countLabel.anchor.centerY)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithThought(thought: Thought) {
        self.thought = thought
        self.titleLabel.text = thought.title
        self.countLabel.text = String(thought.listOfOccurrences.count)
    }

    // MARK: - PRIVATE HELPERS
    @objc private func incrementThoughtCount() {
        guard let currentCountString = self.countLabel.text else { return }
        guard var currentCountInt = Int(currentCountString) else { return }
        guard let thought = self.thought else { return }
        currentCountInt += 1
        thought.listOfOccurrences.append(Date())
        self.countLabel.text = String(currentCountInt)
        self.delegate?.saveThoughts()
    }

    @objc private func decrementThoughtCount() {
        guard let currentCountString = self.countLabel.text else { return }
        guard var currentCountInt = Int(currentCountString), currentCountInt > 0 else { return }
        guard let thought = self.thought else { return }
        currentCountInt -= 1
        thought.listOfOccurrences.removeLast()
        self.countLabel.text = String(currentCountInt)
        self.delegate?.saveThoughts()
    }
}
