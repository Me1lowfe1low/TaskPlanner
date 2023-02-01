//
//  TaskPlannerApp.swift
//  TaskPlanner
//
//  Created by Дмитрий Гордиенко on 30.01.2023.
//

import SwiftUI

@main
struct TaskPlannerApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
            }
        }
    }
}

