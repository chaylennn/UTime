//
//  NewToDo.swift
//  UTime
//
//  Created by maegan on 7/29/25.
//

//this is for the to do list btw
import SwiftUI

struct NewToDo: View {
    var body: some View {
        VStack{
            Text("Task title:")
            TextField("Enter task description", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .cornerRadius(15)
            Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                Text("Is it important?")
            }
            Button() {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            } label: { Text("Save")
            }
            
        }
        .padding()
    }
}

#Preview {
    NewToDo()
}
