import SwiftUI
import UIKit

/// A view wrapper that prevents screenshots and screen recording of its contents.
/// It uses the system's secure text entry layer to mask the content during captures.
public struct SecureView<Content: View>: View {
    private let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        SecureViewRepresentable {
            content
        }
    }
}

private struct SecureViewRepresentable<Content: View>: UIViewRepresentable {
    let content: () -> Content
    
    func makeUIView(context: Context) -> UIView {
        let secureContainer = UIView()
        secureContainer.backgroundColor = .clear
        
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.isUserInteractionEnabled = false
        
        // Find the secure layer
        guard let secureLayer = textField.layer.sublayers?.first else {
            return secureContainer
        }
        
        // Create the hosting controller for our SwiftUI content
        let hostingController = UIHostingController(rootView: content())
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Trick: Add the hosting view to the secure layer's delegate (which is the actual hidden view)
        // Note: iOS 15+ prevents direct addSubview to the layer, so we use a subview of the textfield's hidden container
        let hiddenContainer = textField.subviews.first { String(describing: type(of: $0)).contains("CanvasView") || String(describing: type(of: $0)).contains("TextLayout") } ?? textField.subviews.first
        
        if let container = hiddenContainer {
            container.addSubview(hostingController.view)
            
            NSLayoutConstraint.activate([
                hostingController.view.topAnchor.constraint(equalTo: container.topAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                hostingController.view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: container.trailingAnchor)
            ])
        }
        
        secureContainer.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: secureContainer.topAnchor),
            textField.bottomAnchor.constraint(equalTo: secureContainer.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: secureContainer.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: secureContainer.trailingAnchor)
        ])
        
        return secureContainer
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Updates can be handled here if content changes dynamically
    }
}
