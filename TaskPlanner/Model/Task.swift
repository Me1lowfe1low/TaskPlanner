//
//  Task.swift
//  TaskPlanner
//
//  Created by Дмитрий Гордиенко on 01.02.2023.
//

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
