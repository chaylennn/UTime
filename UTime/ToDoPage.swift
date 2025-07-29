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
            
        }
        if showNewTask{
            NewToDo()
        }
    }
}


#Preview {
    ToDoPage()
}
