// Created for TaskPlanner on 01.02.2023
// by Dmitry Gordienko
// git: https://github.com/Me1lowfe1low
// Using Swift 5.0
// Running on macOS 13.0
//
//  MainTaskView.swift
//  TaskPlanner
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes

import SwiftUI

struct MainTaskView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var taskVault: FetchedResults<MainTask>

    @State var task: MainTask?
    
    var body: some View {
        VStack {
            Section(header: Text(task!.wrappedTitle)
                .font(.title)
                .bold()) {
                VStack(alignment: .leading) {
                    ForEach(task!.subTaskArray, id:\.self) { subTask in
                        HStack(alignment: .top, spacing: 5 ) {
                            Image(systemName: subTask.wrappedCheck ? "checkmark.square" : "square")
                            Text(subTask.wrappedName)
                                .frame(alignment: .leading)
                            Spacer()
                        }
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
