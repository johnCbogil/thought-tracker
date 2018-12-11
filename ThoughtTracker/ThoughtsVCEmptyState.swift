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

    var manageThoughtDelegate: ManageThoughtsDelegate?

    // MARK: - VIEWS
    let callToActionLabel: UILabel = {
        let label = UILabel()
        label.text = "Keep a list of your intrusive thoughts and how many times they occur each day."
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 21, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    let callToActionButton: UIButton = {
        let button = UIButton()
        button.setTitle("+ Create Thought", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 32
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        button.addTarget(self, action: #selector(createThought), for: .touchUpInside)
        return button
    }()

    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(callToActionLabel)
        self.addSubview(callToActionButton)
        activate(
            self.callToActionButton.anchor.centerX,
            self.callToActionButton.anchor.bottom.constant(0),
            self.callToActionLabel.anchor.bottom.to(self.callToActionButton.anchor.top).constant(-50),
            self.callToActionLabel.anchor.paddingHorizontally(10)
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func createThought() {
        self.manageThoughtDelegate?.createThought()
    }
}
