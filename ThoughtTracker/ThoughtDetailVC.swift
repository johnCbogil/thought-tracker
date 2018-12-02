//
//  ThoughtDetailVC.swift
//  ThoughtTracker
//
//  Created by John Bogil on 11/25/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation
import Anchors
import UIKit

class ThoughtDetailVC: UIViewController {
    // MARK: - PROPERTIES
    let thought: Thought
    let formattedOccurrences: [DateCount]

    // MARK: - VIEWS
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(OccurrenceCell.self, forCellReuseIdentifier: OccurrenceCell.identifier)
        tableView.tableFooterView = UIView()
        return tableView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    // MARK: - LIFECYCLE
    init(thought: Thought) {
        self.thought = thought
        self.formattedOccurrences = thought.getFormattedOccurrences()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.titleLabel)
        self.titleLabel.text = self.thought.title
        activate(self.titleLabel.anchor.centerX,
                 self.titleLabel.anchor.paddingHorizontally(10),
                 self.titleLabel.anchor.top.constant(150),
                 self.tableView.anchor.top.to(self.titleLabel.anchor.bottom),
                 self.tableView.anchor.centerX,
                 self.tableView.anchor.bottom.left.right)
    }
}

// MARK: TABLEVIEW DELEGATE METHODS
extension ThoughtDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.formattedOccurrences.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OccurrenceCell.identifier, for: indexPath) as! OccurrenceCell
        let dateCount = self.formattedOccurrences[indexPath.row]
        cell.dateLabel.text = dateCount.dateString
        cell.countLabel.text = String(dateCount.count)
        return cell
    }
}
