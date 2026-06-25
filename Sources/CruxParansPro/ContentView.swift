import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \UserProfile.name) private var profiles: [UserProfile]
    
    @State private var showingAddProfile = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(profiles) { profile in
                    NavigationLink(destination: ProfileDetailView(profile: profile)) {
                        VStack(alignment: .leading) {
                            Text(profile.name)
                                .font(.headline)
                            Text("\(profile.birthCity) (\(String(format: "%.2f", profile.latitude)), \(String(format: "%.2f", profile.longitude)))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteProfiles)
            }
            .navigationTitle("Crux Parans Pro")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: { showingAddProfile = true }) {
                        Label("Add Profile", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddProfile) {
                ProfileFormView()
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private func deleteProfiles(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(profiles[index])
            }
        }
    }
}
