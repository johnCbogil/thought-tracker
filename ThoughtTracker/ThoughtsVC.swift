//
//  ViewController.swift
//  ThoughtTracker
//
//  Created by John Bogil on 11/24/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit
import Anchors
import DefaultsKit
import WebKit

class ThoughtsVC: UIViewController {

    // MARK: - PROPERTIES
    var listOfThoughts = [Thought]()
    let defaults = Defaults(userDefaults: UserDefaults.standard)

    // MARK: - VIEWS
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(ThoughtCell.self, forCellReuseIdentifier: ThoughtCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        return tableView
    }()

    private lazy var addThoughtButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.presentAlert))
        return button
    }()

    private lazy var emptyState: ThoughtsVCEmptyState = {
        let emptyState = ThoughtsVCEmptyState()
        emptyState.manageThoughtDelegate = self
        return emptyState
    }()

    private lazy var swipeLabel: UILabel = {
        let label = UILabel()
        label.text = "Swipe right on a thought to increase the count."
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var feedbackButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "icon_feedback"), style: .plain, target: self, action: #selector(self.presentFeedbackForm))
        return button
    }()

    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.addThoughtButton
        self.navigationItem.leftBarButtonItem = self.feedbackButton
        self.title = "Today's Thoughts"
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.emptyState)
        self.view.addSubview(self.swipeLabel)
        activate(self.tableView.anchor.edges,
                 self.emptyState.anchor.bottom.constant(-120),
                 self.emptyState.anchor.paddingHorizontally(10),
                 self.emptyState.anchor.top,
                 self.swipeLabel.anchor.top.constant(100),
                 self.swipeLabel.anchor.paddingHorizontally(10)
        )
        self.tableView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
        guard let listOfThoughts = defaults.get(for: .thoughtsKey) else { return }
        self.listOfThoughts = listOfThoughts
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.toggleEmptyState()
    }
}

// MARK: - Private Helpers
extension ThoughtsVC {

    private func toggleEmptyState() {
        self.emptyState.isHidden = self.listOfThoughts.count != 0
        self.swipeLabel.isHidden = self.listOfThoughts.count == 0
    }

    @objc private func presentFeedbackForm() {
        self.navigationController?.pushViewController(FeedbackVC(), animated: true)
    }
    
    @objc private func presentAlert() {

        let alert = UIAlertController(title: "Add thought", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            guard let textField = alert?.textFields?.first, let text = textField.text else { return }
            if !text.isEmpty {
                let newThought = Thought(date: Date(), title: text)
                self.listOfThoughts.append(newThought)
                self.saveThoughts()
                self.tableView.reloadData()
            }
        }))
        self.present(alert, animated: true, completion: {  })
    }
}

// MARK: - Thought Management
extension ThoughtsVC: ManageThoughtsDelegate {
    func deleteThought(thought: Thought) {
        self.listOfThoughts = self.listOfThoughts.filter({$0 !== thought})
        self.tableView.reloadData()
        self.saveThoughts()
        self.toggleEmptyState()
    }

    func saveThoughts() {
        defaults.set(self.listOfThoughts, for: .thoughtsKey)
        self.toggleEmptyState()
    }

    func createThought() {
        self.presentAlert()
    }
}

// MARK: - UITableViewDelegate Methods
extension ThoughtsVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfThoughts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ThoughtCell = tableView.dequeueReusableCell(withIdentifier: ThoughtCell.identifier, for: indexPath) as! ThoughtCell
        let thought = self.listOfThoughts[indexPath.row]
        cell.delegate = self
        cell.configureWithThought(thought: thought)
        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi);
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = ThoughtDetailVC(thought: self.listOfThoughts[indexPath.row])
        detailVC.delegate = self
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
