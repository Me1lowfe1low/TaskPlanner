//
//  MainTaskView.swift
//  TaskPlanner
//
//  Created by Дмитрий Гордиенко on 01.02.2023.
//

import SwiftUI

struct MainTaskView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var taskVault: FetchedResults<MainTask>

    @State var task: MainTask?
    
    var body: some View {
        VStack {
            Section(header: Text(task!.wrappedTitle)) {
                VStack(alignment: .leading) {
                    ForEach(task!.subTaskArray, id:\.self) { subTask in
                        Label(subTask.wrappedName, systemImage: "square")
                    }
                }
            }
        }
    }
}

struct MainTaskView_Previews: PreviewProvider {
    static var previews: some View {
        MainTaskView(task: MainTask())
    }
}
