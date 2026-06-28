import SwiftUI
import UIKit

/// Utility wrapper for sharing content (images, URLs, text) via the native iOS Share Sheet
public struct ShareSheet: UIViewControllerRepresentable {
    public var activityItems: [Any]
    public var applicationActivities: [UIActivity]? = nil

    public init(activityItems: [Any], applicationActivities: [UIActivity]? = nil) {
        self.activityItems = activityItems
        self.applicationActivities = applicationActivities
    }

    public func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
        return controller
    }

    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No updates needed
    }
}

/// Helper extension to trigger the share sheet easily from any View
public extension View {
    /// Present a native share sheet with the specified items
    func shareSheet(isPresented: Binding<Bool>, items: [Any]) -> some View {
        self.sheet(isPresented: isPresented) {
            ShareSheet(activityItems: items)
        }
    }
}

/// Mock Example:
/// struct ResultCard: View {
///     @State private var showShareSheet = false
///     var body: some View {
///         Button("🌟 自分の宿命（属性）を世界に宣言する") {
///             showShareSheet = true
///         }
///         .shareSheet(isPresented: $showShareSheet, items: ["私は #None民 です！\nCruxParansでチェック！", URL(string: "https://example.com")!])
///     }
/// }
