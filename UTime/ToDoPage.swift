//
//  ToDoPage.swift
//  UTime
//
//  Created by Jolin Wang on 7/29/25.
//

import SwiftUI
import SwiftData


struct ToDoPage: View {
    @State private var showNewTask = false
    @Query var toDos: [ToDoItem]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack{
            //This is the to do list title and the + button
            HStack{
                Text("To-Do List")
                    .font(.system(size:40))
                    .fontWeight(.black)
                Spacer()
                Button() {
                    withAnimation{
                        showNewTask = true
                    }
                } label: { Text("+")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
            .padding()
            Spacer()
            
            //add a list for the tasks
            List{
                ForEach(toDos){ toDoItem in
                    if toDoItem.isImportant{
                        Text("!!" + toDoItem.title)
                    } else {
                        Text(toDoItem.title)
                    }
                }
                .onDelete(perform: deleteToDo)
            }
        }
        if showNewTask{
            NewToDo(showNewTask: $showNewTask, toDoItem: ToDoItem(title:"", isImportant: false))
        }
        
    }
    
    //adding the delete task function
    
    func deleteToDo(at offsets: IndexSet){
        for offset in offsets{
            let toDoItem = toDos[offset]
            modelContext.delete(toDoItem)
            
        }
    }
    
}


#Preview {
    ToDoPage()
        .modelContainer(for: ToDoItem.self)
}
