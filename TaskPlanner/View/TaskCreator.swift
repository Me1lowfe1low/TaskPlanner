//
//  TaskCreator.swift
//  TaskPlanner
//
//  Created by Дмитрий Гордиенко on 30.01.2023.
//

import SwiftUI

struct TaskCreator: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var taskVault: FetchedResults<MainTask>
    
    @StateObject var taskList: Tasks = Tasks()
    
    var body: some View {
        VStack( alignment: .leading) {
            List {
                TextField("Title", text: $taskList.title)
                    .font(.title)
                ForEach($taskList.tasks, id: \.self) { $task in
                    TextField("Sub-task title", text: $task.name)
                        .font(.caption)
                }
                .onDelete(perform: removeSubTask )
                
                HStack( alignment: .top) {
                    Label("",systemImage: "plus")
                    Text("List sub task")
                }
                .padding(.horizontal)
                .onTapGesture {
                    taskList.tasks.append(Task())
                }
            }
        }
        Button("Save") {
            saveMainTask()
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
