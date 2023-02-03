// Created for TaskPlanner on 01.02.2023
// by Dmitry Gordienko
// git: https://github.com/Me1lowfe1low
// Using Swift 5.0
// Running on macOS 13.0
//
//  Task.swift
//  TaskPlanner
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes

import Foundation

struct Task: Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String = ""
    var position: Int = 0
    var isChecked: Bool = false
    
    init(position: Int) {
        self.position = position
    }
    
    init(id: UUID, name: String, position: Int, isChecked: Bool) {
        self.id = id
        self.name = name
        self.position = position
        self.isChecked = isChecked
    }
}
