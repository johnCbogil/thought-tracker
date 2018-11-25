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

protocol ListOfThoughtsTableViewDelegate: class {
    func saveThoughts()
}

class ThoughtsVC: UIViewController {

    // MARK: - PROPERTIES
    var listOfThoughts = [Thought]()
    let defaults = Defaults(userDefaults: UserDefaults.standard)
    let thoughtsKey = Key<[Thought]>("thoughtsKey")

    // MARK: - VIEWS
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(ThoughtCell.self, forCellReuseIdentifier: ThoughtCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        return tableView
    }()

    private lazy var addThoughtButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ThoughtsVC.presentAlert))
        return button
    }()

    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.addThoughtButton
        self.title = "Your Thoughts"
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        activate(self.tableView.anchor.edges)
        self.tableView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
        guard let listOfThoughts = defaults.get(for: thoughtsKey) else { return }
        self.listOfThoughts = listOfThoughts
    }
}

// MARK: - Helpers
extension ThoughtsVC: ListOfThoughtsTableViewDelegate {

    func saveThoughts() {
        defaults.set(self.listOfThoughts, for: thoughtsKey)
    }

    @objc private func presentAlert() {

        //1. Create the alert controller.
        let alert = UIAlertController(title: "Add thought", message: nil, preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField()

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            guard let textField = alert?.textFields?.first, let text = textField.text else { return }
            if !text.isEmpty {
                let newThought = Thought(count: 0, title: text)
                self.listOfThoughts.append(newThought)
                self.saveThoughts()
                self.tableView.reloadData()
            }
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: {  })
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
    }
}
