import SwiftUI

struct LightContentView: View {
    @State private var topStar: String = "Galactic Center"
    @State private var topStarLore: String = "The star that locks thy soul exists nowhere in the firmament. Thou belongest to no faction of the gods; thou art a person of the absolute Void."
    
    // Light Edition Colors (Can be more modern/mystical)
    let deepSpaceBlack = Color(red: 5/255, green: 5/255, blue: 15/255)
    let starWhite = Color.white

    var body: some View {
        ZStack {
            deepSpaceBlack.ignoresSafeArea()
            
            VStack(spacing: 32) {
                Text("Crux Parans")
                    .font(.system(size: 24, weight: .light, design: .serif))
                    .foregroundColor(starWhite)
                
                Spacer()
                
                Text("YOUR COSMIC ALIGNMENT")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(starWhite.opacity(0.7))
                    .tracking(2.0)
                
                Text(topStar)
                    .font(.system(size: 36, weight: .bold, design: .serif))
                    .foregroundColor(starWhite)
                
                Text(topStarLore)
                    .font(.system(size: 16, weight: .regular, design: .serif))
                    .foregroundColor(starWhite.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .lineSpacing(6)
                
                Spacer()
                
                Button(action: shareToSocialMedia) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share your Destiny")
                    }
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(deepSpaceBlack)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 32)
                    .background(starWhite)
                    .cornerRadius(30)
                }
                .padding(.bottom, 32)
            }
        }
    }
    
    private func shareToSocialMedia() {
        let hashtag = topStar == "Galactic Center" ? "#GalacticCenterTribe" : "#\(topStar.replacingOccurrences(of: " ", with: ""))Tribe"
        let text = "Navigating the cosmic ocean. \(hashtag) #CruxParans"
        
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootVC = window.rootViewController {
            // For iPad compatibility
            if let popover = activityVC.popoverPresentationController {
                popover.sourceView = window
                popover.sourceRect = CGRect(x: window.bounds.midX, y: window.bounds.midY, width: 0, height: 0)
                popover.permittedArrowDirections = []
            }
            rootVC.present(activityVC, animated: true, completion: nil)
        }
    }
}
