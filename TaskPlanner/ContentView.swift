// Created for TaskPlanner on 30.01.2023
// by Dmitry Gordienko
// git: https://github.com/Me1lowfe1low
// Using Swift 5.0
// Running on macOS 13.0
//
//  ContentView.swift
//  TaskPlanner
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \MainTask.timestamp, ascending: false)]) var taskVault: FetchedResults<MainTask>
    
    var body: some View {
        VStack{
            ZStack {
                List {
                    ForEach(taskVault, id: \.self) { mainTask in
                        NavigationLink(destination: {
                            MainTaskEditor(task: mainTask)
                                .environment(\.managedObjectContext, moc)
                                .environmentObject(dataController)
                        },
                                       label: { MainTaskView(task: mainTask)
                            
                        })
                    }
                    .onDelete(perform: deleteTask)
                }
                VStack(alignment: .trailing) {
                    Spacer()
                    HStack(alignment: .bottom) {
                        Spacer()
                        NavigationLink(destination: {
                            TaskCreator()
                                .environment(\.managedObjectContext, moc)
                                .environmentObject(dataController)
                        },
                            label: {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                        })
                    }
                    .padding()
                }
            }
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        for offset in offsets {
            dataController.deleteTask(moc, task: taskVault[offset])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
