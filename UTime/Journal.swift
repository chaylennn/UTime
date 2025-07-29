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
            List {
                ForEach(entries) { entry in
                    VStack(alignment: .leading) {
                        Text(entry.title)
                            .font(.headline)
                        Text(entry.content)
                        Text(entry.date.formatted())
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                .onDelete(perform: deleteEntry)
            }
            .navigationTitle("Journal")
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 12) {
                    TextField("Title", text: $newTitle)
                        .textFieldStyle(.roundedBorder)

                    TextField("Content", text: $newContent)
                        .textFieldStyle(.roundedBorder)

                    DatePicker("Date", selection: $newDate, displayedComponents: .date)

                    Button("Save") {
                        withAnimation {
                            let newEntry = JournalEntry(title: newTitle, content: newContent, date: newDate)
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

    func deleteEntry(at offsets: IndexSet) {
        for index in offsets {
            let entry = entries[index]
            context.delete(entry)
        }
    }
}

#Preview {
    Journal()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
