import SwiftUI
import SwiftData

struct NoteEditorSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    let profile: UserProfile
    let eventID: String
    
    @State private var content: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Professional Observation")) {
                    TextEditor(text: $content)
                        .frame(minHeight: 150)
                }
            }
            .navigationTitle("Inline Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveNote()
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let existingNote = profile.notes.first(where: { $0.eventID == eventID }) {
                    content = existingNote.content
                }
            }
        }
    }
    
    private func saveNote() {
        if let existingNote = profile.notes.first(where: { $0.eventID == eventID }) {
            if content.isEmpty {
                modelContext.delete(existingNote)
                profile.notes.removeAll(where: { $0.eventID == eventID })
            } else {
                existingNote.content = content
                existingNote.timestamp = Date()
            }
        } else if !content.isEmpty {
            let newNote = AstrologyNote(eventID: eventID, content: content)
            profile.notes.append(newNote)
        }
        
        try? modelContext.save()
    }
}
