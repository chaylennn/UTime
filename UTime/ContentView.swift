//
//  ContentView.swift
//  UTime
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct ContentView: View {
    let date = Date()
    var body: some View {
        NavigationStack{
            VStack(spacing: 10) {
                Text(getCurrentDate())
                Text(getCurrentTime())
                Spacer()
                //create the 3 navigation buttons
                HStack(spacing: 50) {
                    NavigationLink(destination: CustomTimerView()){
                        Image("Timer")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                    }
                    NavigationLink(destination: ToDoPage()){
                        Image("To Do")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                        
                    }
                    NavigationLink(destination: Resources()){
                        Image("Resources")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                        
                    }
                }
                HStack(spacing: 50){
                    Text("Timer")
                    Text("To Do")
                    Text("Resources")
                }
                .padding(.bottom, 600)
            }
            .padding()
        }
    }
    //get current date function
    func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from:date)
    }
    
    //get current time function
    func getCurrentTime() -> String{
        let time = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: time)
    }
}

#Preview {
    ContentView()
}
