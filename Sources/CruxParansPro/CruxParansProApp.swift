import SwiftUI
import SwiftData

@main
struct CruxParansProApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: UserProfile.self)
    }
}
