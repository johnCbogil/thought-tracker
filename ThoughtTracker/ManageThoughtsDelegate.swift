//
//  SaveThoughtsDelegate.swift
//  ThoughtTracker
//
//  Created by John Bogil on 12/2/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

protocol ManageThoughtsDelegate {
    func saveThoughts()
    func deleteThought(thought: Thought)
    func createThought()
}
