//
//  MainTaskEditor.swift
//  TaskPlanner
//
//  Created by Дмитрий Гордиенко on 01.02.2023.
//

import SwiftUI

struct MainTaskEditor: View {
    @Environment(\.managedObjectContext) var moc
    @StateObject var taskList: Tasks = Tasks()
    @State var task: MainTask
    
    var body: some View {
        VStack( alignment: .leading) {
            List {
                TextField(task.title!, text: $taskList.title)
                    .font(.title)
                ForEach(taskList.tasks.indices, id: \.self) { index in
                    TextField( (index < task.subTaskArray.count) ? task.subTaskArray[index].wrappedName : "", text: $taskList.tasks[index].name)
                        .font(.callout)
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
        .onAppear(perform: fillStruct)
        Button("Save") {
            saveChanges()
        }
        Text("")
    }
}
