//
//  TaskCreator.swift
//  TaskPlanner
//
//  Created by Дмитрий Гордиенко on 30.01.2023.
//

import SwiftUI

struct TaskCreator: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: []) var taskVault: FetchedResults<MainTask>
    
    @StateObject var taskList: Tasks = Tasks()
    
    var body: some View {
        VStack( alignment: .leading) {
                
            List {
                TextField("Title", text: $taskList.title)
                    .font(.title)
                    .bold()
                    .padding()
                ForEach($taskList.tasks, id: \.id) { $task in
                    HStack {
                        Image(systemName: task.isChecked ? "checkmark.square" : "square")
                            .onTapGesture(perform: {
                                print("User tapped at \(task.position)")
                                task.isChecked.toggle()
                            })
                        Divider()
                        TextField("Sub-task title", text: $task.name)
                            .font(.caption)
                        Spacer()
                    }
                }
                .onMove(perform: move )
                .onDelete(perform: removeSubTask )
                HStack( alignment: .top) {
                    Label("",systemImage: "plus")
                    Text("List sub task")
                }
                .padding(.horizontal)
                .onTapGesture {
                    taskList.tasks.append(Task(position: taskList.tasks.count))
                }
                
            }
        }
        Button("Save") {
            saveMainTask()
            dismiss()
        }
    }
}
   

struct TaskCreator_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            TaskCreator()
        }
    }
}
