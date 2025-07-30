//
//  NewToDo.swift
//  UTime
//
//  Created by maegan on 7/29/25.
//

//this is for the to do list btw
import SwiftUI

struct NewToDo: View {
    @Binding var showNewTask: Bool
    @Bindable var toDoItem: ToDoItem
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack{
            Text("Task title:")
            TextField("Enter task description", text: $toDoItem.title)
                .cornerRadius(15)
            Toggle(isOn: $toDoItem.isImportant) {
                Text("Is it important?")
            }
            Button() {
                addToDo()
                showNewTask = false
            } label: { Text("Save")
            }
            
        }
        .padding()
    }
    func addToDo(){
        let toDo = ToDoItem(title: toDoItem.title, isImportant: toDoItem.isImportant)
        modelContext.insert(toDo)
    }
}

#Preview {
    NewToDo(showNewTask: .constant(false), toDoItem: ToDoItem(title: "", isImportant: false))
}
