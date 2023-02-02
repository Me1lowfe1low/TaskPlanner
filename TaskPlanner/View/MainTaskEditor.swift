//
//  MainTaskEditor.swift
//  TaskPlanner
//
//  Created by Дмитрий Гордиенко on 01.02.2023.
//

import SwiftUI

struct MainTaskEditor: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @StateObject var taskList: Tasks = Tasks()
    @State var task: MainTask
    
    var body: some View {
        VStack( alignment: .leading) {
            List {
                TextField(task.title!, text: $taskList.title)
                    .font(.title)
                    .bold()
                    .padding()
                ForEach(taskList.tasks.indices, id: \.self) { index in
                    HStack {
                        Image(systemName: taskList.tasks[index].isChecked ? "checkmark.square" : "square")
                            .onTapGesture(perform: {
                                print("User tapped at \(taskList.tasks[index].position)")
                                taskList.tasks[index].isChecked.toggle()
                            })
                        Divider()
                        TextField( (index < task.subTaskArray.count) ? task.subTaskArray[index].wrappedName : "", text: $taskList.tasks[index].name)
                            .font(.callout)
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
                    taskList.tasks.append(Task(position: taskList.tasks.count ))
                }
            }
        }
        .onAppear(perform: fillStruct)
        Button("Save") {
            saveChanges()
            dismiss()
        }
        Text("")
    }
}
