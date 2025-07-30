import SwiftUI
import SwiftData

struct Journal: View {
    @Query(sort: \JournalEntry.date, order: .reverse) private var entries: [JournalEntry]
    @Environment(\.modelContext) private var context

    @State private var newTitle: String = ""
    @State private var newContent: String = ""
    @State private var newDate: Date = .now

    var body: some View {
        NavigationStack {
            VStack {
                // Adding a title and subtitle
                VStack(alignment: .center, spacing: 4) {
                    Text("Journal")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .bold()

                    Text("Write down your thoughts and clear your mind ✨")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
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
                                Text(entry.content)
                                Text(entry.date.formatted())
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                            
                        }
                        
                        //if title is empty use a cactus for the title
                        else if entry.title == "" {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("🌵")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                Text(entry.content)
                                Text(entry.date.formatted())
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                            
                        }
                        
                        //if content is empty
                        else if entry.content == "" {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(entry.title)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                Text("✮")
                                Text(entry.date.formatted())
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                            
                        }

                    }
                    .onDelete(perform: deleteEntry)
                }
                .listStyle(.plain)
            }

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

                    Button("Save") {
                        withAnimation {
                            let newEntry = JournalEntry(
                                title: newTitle,
                                content: newContent,
                                date: newDate
                            )
                            context.insert(newEntry)
                            newTitle = ""
                            newContent = ""
                            newDate = .now
                        }
                    }
                    .buttonStyle(.borderedProminent)
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
