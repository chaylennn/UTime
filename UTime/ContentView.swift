//
//  ContentView.swift
//  UTime
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

//global variable so that all files can access what mood the user is feeling after hitting one of the mood buttons
var moodToday = ""

struct ContentView: View {
    @State private var moodText = "How are you feeling?"
    let date = Date()
    var body: some View {
            NavigationStack{
                //create the mood board
                    
                VStack(spacing: 10) {
                    Text(getCurrentDate())
                    Text(getCurrentTime())
                      
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
                    //text for buttons on top
                    HStack(spacing: 65){
                        Text("         Timer")
                        Text("  To Do")
                        Text("Resources    ")
                    }
                    .padding(.bottom, 50)
                    
                    //add the mood board z stack
                    ZStack {
                        Color(.systemBrown)
                            .frame(width:350, height: 280)
                            .cornerRadius(30)
                        VStack(spacing: 30){
                            Text(moodText)
                                .fontWeight(.semibold)
                            //first row of moods
                            HStack(spacing: 40){
                                Button (action:{
                                    moodToday = "joyous"
                                    moodText = "You are feeling joyous!"
                                }) {
                        
                                        Image("joyous")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 70, height: 70)
                                            .clipShape(Circle())
                                    }
                                
                                Button (action:{
                                    moodToday = "content"
                                    moodText = "You are feeling content :)"
                                }) {
                                    Image("content")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 70, height: 70)
                                        .clipShape(Circle())
                                }
                                Button (action:{
                                    moodToday = "bored"
                                    moodText = "You are feeling bored."
                                }) {
                                    Image("bored")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 70, height: 70)
                                        .clipShape(Circle())
                                }
                                
                            }
                            //second row of moods
                            
                            HStack(spacing: 40){
                                Button (action:{
                                    moodToday = "sad"
                                    moodText = "You are feeling sad :("
                                }) {
                        
                                        Image("sad")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 70, height: 70)
                                            .clipShape(Circle())
                                    }
                                
                                Button (action:{
                                    moodToday = "crying"
                                    moodText = "You feel like crying :'("
                                }) {
                                    Image("crying")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 70, height: 70)
                                        .clipShape(Circle())
                                }
                                
                            }
                            
                        }
                    }
                    
                    //create the navigation to journal button
                    ZStack(){
                    Color(.systemBrown)
                        .frame(width: 350, height: 100)
                        .cornerRadius(30)
                        
                        NavigationLink(destination: Journal()){
                            HStack(spacing: 50){
                                Text("Journal")
                                    .foregroundColor(.black)
                                    .font(.title)
                                Image("Journal")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 70, height: 70)
                                    .clipShape(Circle())
                            }
                        }
                        
                    }
                    .padding(.top, 50)
                    
                }
                    
                .padding(.bottom, 100)
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
