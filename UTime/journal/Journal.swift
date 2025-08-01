//
//  
//  UTime
//
//  Created by chaylen on 7/29/25.
//
//

import SwiftUI
import SwiftData


struct Journal: View {
    @Query(sort: \JournalEntry.date, order: .reverse) private var entries: [JournalEntry]
    @Environment(\.modelContext) private var context
    
    @State private var newTitle: String = ""
    @State private var newContent: String = ""
    @State private var newDate: Date = .now
    @State private var newMood: String = moodToday
    
    //dictionary of messages and affirmations according to the mood they are feeling
    
    private var moodMsg = ["joyous": "Yay! Write your happy thoughts down! 🤗", "content": "Write about your day! 🩷", "bored": "Maybe journaling will help you feel more excited! 😛", "sad": "Want to talk about it? Enter in your feelings here, you got this! 💪", "crying": "Let it all out here — you're safe and supported 💙"]
    
    //dictionary of emojis to go along with each mood
    private var moodEmoji = ["joyous": "☺☀", "content": "♡❤", "bored": "🥱", "sad": "☁☹︎", "crying": "😿"]
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                // Adding a title and subtitle
                VStack(alignment: .center, spacing: 4) {
                    Text("Journal")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .bold()
                    
                    //text shown if user does not input a mood from home
                    if(moodToday == ""){
                        Text("Write down your thoughts to clear your mind ⋆.˚⟡ ࣪ ˖")
                        
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    
                    
                    //only show if the user selected a mood from the home page
                    if(moodToday != ""){
                        Text("Your mood today is: " + moodToday)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        
                        //display a msg according to the moodToday from the home page and displays empty if value is null
                        Text(moodMsg[moodToday] ?? "")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    
                    
                }
                .padding(.horizontal)
                .padding(.top)
                
                // allows for each saved entry to appear in a list
                List {
                    ForEach(entries) { entry in
                        
                        //if both title & content are filled
                        if entry.title != "" && entry.content != "" {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(entry.title)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                
                                Text("ᯓ★ " + entry.content)
                                
                                
                                
                                //adds mood if the value exists and is not empty and then displays if the respective emoji
                                if entry.mood != nil && entry.mood != ""{
                                    Text(moodEmoji[entry.mood ?? ""] ?? "")
                                }
                                
                                Text(entry.date.formatted())
                                    .font(.footnote)
                                
                                    .foregroundColor(.secondary)
                                
                                    .foregroundColor(.gray)
                                
                                
                                
                                
                                
                            }
                            .padding(.vertical, 4)
                            .cornerRadius(15)
                            
                        }
                        
                        //if title is empty use a cactus for the title
                        
                        //would delete this and following else if for better efficiency
                        else if entry.title == "" && entry.content != ""{
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Unititled")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                Text("ᯓ★ " + entry.content)
                                
                            }
                        }
                                //if content is empty
                                else if entry.title != "" && entry.content == "" {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(entry.title)
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                        
                                        Text("ᯓ★ ")
                                            .foregroundColor(Color("dark green"))
                                        Text("✮")
                                        
                                        //adds mood if the value exists and is not empty and then displays if the respective emoji
                                        if entry.mood != nil && entry.mood != ""{
                                            Text(moodEmoji[entry.mood ?? ""] ?? "")
                                        }
                                        
                                        Text(entry.date.formatted())
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                        
                                    }
                                    .padding(.vertical, 4)
                                    
                                }
                                
                            }
                            .onDelete(perform: deleteEntry)
                            .listRowBackground(AppColorTheme.lightGreenColor)
                        }
                            .listStyle(.plain)
                    }
                    .background(AppColorTheme.lightGreenColor)
                    
                    // allows the user to add a new entry located on the bottom of the view
                    .safeAreaInset(edge: .bottom) {
                        VStack(spacing: 12) {
                            Text("New Entry")
                                .font(.headline)
                            
                            TextField("Title", text: $newTitle)
                                .textFieldStyle(.roundedBorder)
                            
                            TextField("Content", text: $newContent)
                                .textFieldStyle(.roundedBorder)
                            
                            DatePicker("Date", selection: $newDate, displayedComponents: .date)
                            
                            //when hitting the save button
                            Button("Save") {
                                withAnimation {
                                    let newEntry = JournalEntry(
                                        title: newTitle,
                                        content: newContent,
                                        date: newDate,
                                        mood: newMood
                                    )
                                    context.insert(newEntry)
                                    
                                    newTitle = ""
                                    newContent = ""
                                    newDate = .now
                                
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(AppColorTheme.lightBrownColor)
                            .cornerRadius(20)
                            
                        }
                        .padding()
                        .background(.bar)
                    }
                }
                
            }
            
            // allows user to delete entry
            func deleteEntry(at offsets: IndexSet) {
                for index in offsets {
                    let entryToDelete = entries[index]
                    context.delete(entryToDelete)
                }
            }
        }
        
        #Preview {
            Journal()
                .modelContainer(for: JournalEntry.self, inMemory: true)
        }
