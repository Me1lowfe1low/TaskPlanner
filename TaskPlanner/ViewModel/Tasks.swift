//
//  Tasks.swift
//  TaskPlanner
//
//  Created by Дмитрий Гордиенко on 01.02.2023.
//

import Foundation
import CoreData

class Tasks: ObservableObject {
    @Published var id: UUID = UUID()
    @Published var timestamp: Date = Date()
    @Published var title = "Title"
    @Published var tasks = [Task]()
    
}
