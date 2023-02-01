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
}
