import SwiftUI
import SwiftData

@main
struct CruxParansProApp: App {
    @AppStorage("isSubscribed") private var isSubscribed: Bool = false

    var body: some Scene {
        WindowGroup {
            if isSubscribed {
                ContentView()
            } else {
                PaywallView(isSubscribed: $isSubscribed)
            }
        }
        .modelContainer(for: UserProfile.self)
    }
}
