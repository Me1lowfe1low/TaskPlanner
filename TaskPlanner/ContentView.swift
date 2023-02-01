//
//  ContentView.swift
//  TaskPlanner
//
//  Created by Дмитрий Гордиенко on 30.01.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var taskVault: FetchedResults<MainTask>
    
    var body: some View {
        VStack{
            ZStack {
                List {
                    ForEach(taskVault, id: \.self) { mainTask in
                        NavigationLink(destination: {
                            MainTaskEditor(task: mainTask)
                                .environment(\.managedObjectContext, moc)
                        },
                                       label: { MainTaskView(task: mainTask)
                            
                        })
                    }
                    .onDelete(perform: deleteTask)
                }
                //Button at the end of the list
                VStack(alignment: .trailing) {
                    Spacer()
                    HStack(alignment: .bottom) {
                        Spacer()
                        NavigationLink(destination: {
                            TaskCreator()
                                .environment(\.managedObjectContext, moc)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
