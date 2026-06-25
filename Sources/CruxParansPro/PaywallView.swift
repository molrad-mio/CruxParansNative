import SwiftUI

struct PaywallView: View {
    @Binding var isSubscribed: Bool
    
    // Medical Grade Colors
    let paperWhite = Color(red: 245/255, green: 245/255, blue: 220/255)
    let deepNavyBlack = Color(red: 10/255, green: 17/255, blue: 40/255)
    
    var body: some View {
        ZStack {
            deepNavyBlack.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                Image(systemName: "lock.shield")
                    .font(.system(size: 80))
                    .foregroundColor(paperWhite)
                
                Text("Alpheratz Lab Pro")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(paperWhite)
                
                Text("The ultimate celestial calculation engine for professional astrologers. Unlock full access to the 30-star database, Parans timelines, and CSV reporting.")
                    .font(.system(size: 16))
                    .foregroundColor(paperWhite.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Spacer()
                
                VStack(spacing: 15) {
                    Button(action: {
                        // Mock Purchase Action
                        isSubscribed = true
                    }) {
                        Text("Subscribe for $99.00 / month")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(deepNavyBlack)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(paperWhite)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        // Mock Restore Action
                        isSubscribed = true
                    }) {
                        Text("Restore Purchases")
                            .font(.system(size: 14))
                            .foregroundColor(paperWhite.opacity(0.7))
                    }
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 50)
            }
        }
    }
}
