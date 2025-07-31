//
//  NewToDo.swift
//  UTime
//
//  Created by maegan on 7/29/25.
//

//this is for the to do list btw it pops up after u click the + button
import SwiftUI

struct NewToDo: View {
    @Binding var showNewTask: Bool
    @Bindable var toDoItem: ToDoItem
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        ZStack{
            Color(AppColorTheme.darkGreenColor)
                .ignoresSafeArea()
            VStack{
                Text("Task title:")
                    .fontWeight(.bold)
                    .foregroundColor(AppColorTheme.creamColor)
                TextField("Enter task description", text: $toDoItem.title)
                    .padding()
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(15)
                    .padding()
                    .foregroundColor(AppColorTheme.darkGreenColor)
                //toggle
                Toggle(isOn: $toDoItem.isImportant) {
                    Text("Is it important?")
                }
                .foregroundColor(AppColorTheme.creamColor)
                //button
                .padding()
                Button() {
                    addToDo()
                    showNewTask = false
                } label: { Text("Save")
                }
                .foregroundColor(AppColorTheme.creamColor)
                
            }
            .padding(25)
        }
        
        
        
    }
    func addToDo(){
        let toDo = ToDoItem(title: toDoItem.title, isImportant: toDoItem.isImportant)
        modelContext.insert(toDo)
    }
}

#Preview {
    NewToDo(showNewTask: .constant(false), toDoItem: ToDoItem(title: "", isImportant: false))
}
