import SwiftUI
import SwiftData

@main
struct CruxParansLightApp: App {
    var body: some Scene {
        WindowGroup {
            LightContentView()
        }
        .modelContainer(for: UserProfile.self)
    }
}
