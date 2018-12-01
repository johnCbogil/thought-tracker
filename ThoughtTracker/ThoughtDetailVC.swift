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

extension ThoughtDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.thought.getFormattedOccurrences().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OccurrenceCell.identifier, for: indexPath) as! OccurrenceCell
        let dateCount = self.thought.getFormattedOccurrences()[indexPath.row]
        cell.dateLabel.text = dateCount.dateString
        cell.countLabel.text = String(dateCount.count)
        return cell
    }
}

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

struct DateCount: Codable {
    var dateString: String
    var count: Int
}
