import SwiftUI

struct ResultView: View {
    let guildStar: GuildStar
    
    @State private var showShareSheet = false
    @State private var navigateToBilling = false
    
    // Gothic colors
    let obsidianBlack = Color(red: 10/255, green: 10/255, blue: 15/255)
    let bloodCrimson = Color(red: 138/255, green: 3/255, blue: 3/255)
    let oldGold = Color(red: 197/255, green: 179/255, blue: 88/255)
    
    var body: some View {
        ZStack {
            obsidianBlack.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    
                    Text("Thy Soul's Constellation")
                        .font(.custom("Palatino", size: 18))
                        .foregroundColor(.gray)
                        .tracking(4)
                        .padding(.top, 40)
                    
                    Text(guildStar.emoji)
                        .font(.system(size: 80))
                        .shadow(color: guildStar.name == "None" ? .cyan : oldGold, radius: 20, x: 0, y: 0)
                    
                    Text("【 \(guildStar.name) 】")
                        .font(.custom("Palatino-Bold", size: 36))
                        .foregroundColor(oldGold)
                    
                    Text(guildStar.title)
                        .font(.custom("Palatino-Italic", size: 20))
                        .foregroundColor(bloodCrimson)
                    
                    Divider().background(oldGold).padding(.horizontal, 40)
                    
                    Text(guildStar.flavorText)
                        .font(.custom("Palatino", size: 16))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .lineSpacing(8)
                        .padding(.horizontal, 30)
                    
                    Divider().background(oldGold).padding(.horizontal, 40)
                    
                    // Share Button
                    Button(action: {
                        showShareSheet = true
                    }) {
                        HStack {
                            Image(systemName: "sparkles")
                            Text("🌟 自分の宿命（属性）を世界に宣言する")
                        }
                        .font(.custom("Palatino-Bold", size: 14))
                        .foregroundColor(obsidianBlack)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(oldGold)
                        .cornerRadius(8)
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 20)
                    .shareSheet(
                        isPresented: $showShareSheet, 
                        items: [
                            "I am locked by 【\(guildStar.name)】 - \(guildStar.title).\n\n\(guildStar.flavorText)\n\n#CruxGuild #\(guildStar.name == "None" ? "None民" : "宿命の民")"
                        ]
                    )
                    
                    // Accept Destiny Button (To Billing/Pro)
                    Button(action: {
                        navigateToBilling = true
                    }) {
                        Text("𝔇𝔢𝔠𝔯𝔢𝔢 𝔄𝔠𝔠𝔢𝔭𝔱𝔢𝔡 ［ 𝔜𝔢𝔰 / 𝔖𝔦𝔤𝔫𝔞𝔱𝔲𝔯𝔢 ］")
                            .font(.custom("Palatino-Bold", size: 16))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(bloodCrimson)
                            .cornerRadius(8)
                            .shadow(color: bloodCrimson.opacity(0.5), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 40)
                    
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(obsidianBlack, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        // Dummy Navigation to a Billing Placeholder
        .navigationDestination(isPresented: $navigateToBilling) {
            BillingMockView(guildStar: guildStar)
        }
    }
}

// Dummy Billing View
struct BillingMockView: View {
    let guildStar: GuildStar
    let obsidianBlack = Color(red: 10/255, green: 10/255, blue: 15/255)
    let oldGold = Color(red: 197/255, green: 179/255, blue: 88/255)
    
    var body: some View {
        SecureView {
            ZStack {
                obsidianBlack.ignoresSafeArea()
                VStack(spacing: 20) {
                    Text("The Hidden Calendar")
                        .font(.custom("Palatino-Bold", size: 28))
                        .foregroundColor(oldGold)
                    
                    Text("Here lies the exact dates when the 4 Major Planets align with your fate: \(guildStar.name).")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Text("⚠️ This view is protected by SecureView.\nScreenshots and screen recordings are blacked out.")
                        .font(.caption)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .navigationTitle("Sacred Transit")
    }
}
