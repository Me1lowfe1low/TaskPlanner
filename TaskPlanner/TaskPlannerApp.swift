// Created for TaskPlanner on 30.01.2023
// by Dmitry Gordienko
// git: https://github.com/Me1lowfe1low
// Using Swift 5.0
// Running on macOS 13.0
//
//  TaskPlannerApp.swift
//  TaskPlanner
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes

import SwiftUI
import CoreData

@main
struct TaskPlannerApp: App {
    let container = NSPersistentContainer(name: "TaskPlanner")

    var body: some Scene {
        WindowGroup {
            let context = container.viewContext
            let dataController = DataController(context, container: container)
            
            NavigationView {
                ContentView()
                    .environment(\.managedObjectContext, context)
                    .environmentObject(dataController)
            }
        }
    }
}

