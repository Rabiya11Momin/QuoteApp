import SwiftUI

struct ContentView: View {
    @StateObject private var quoteManager = QuoteManager()
    @State private var showingShareSheet = false
    @State private var showingCopiedAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        Spacer(minLength: 20)
                        
                        // App Title
                        VStack(spacing: 8) {
                            Image(systemName: "quote.bubble.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                            
                            Text("Daily Quotes")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        
                        // Quote Card
                        if quoteManager.isLoading {
                            QuoteCardView(
                                text: "Loading inspiring quote...",
                                author: "Please wait",
                                isLoading: true
                            )
                        } else {
                            QuoteCardView(
                                text: quoteManager.currentQuote.text,
                                author: quoteManager.currentQuote.author,
                                isLoading: false
                            )
                            .onTapGesture {
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            }
                        }
                        
                        // Action Buttons
                        VStack(spacing: 16) {
                            // New Quote Button
                            Button(action: {
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                quoteManager.fetchNewQuote()
                            }) {
                                HStack {
                                    Image(systemName: "arrow.clockwise")
                                        .font(.system(size: 18, weight: .semibold))
                                    Text("New Quote")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.orange, Color.red]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(25)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                            }
                            .disabled(quoteManager.isLoading)
                            .scaleEffect(quoteManager.isLoading ? 0.95 : 1.0)
                            .animation(.easeInOut(duration: 0.1), value: quoteManager.isLoading)
                            
                            // Action Buttons Row
                            HStack(spacing: 12) {
                                // Share Button
                                Button(action: {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                    showingShareSheet = true
                                }) {
                                    HStack {
                                        Image(systemName: "square.and.arrow.up")
                                        Text("Share")
                                    }
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 44)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(22)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 22)
                                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                    )
                                }
                                
                                // Copy Button
                                Button(action: {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                    copyQuoteToClipboard()
                                }) {
                                    HStack {
                                        Image(systemName: "doc.on.doc")
                                        Text("Copy")
                                    }
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 44)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(22)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 22)
                                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                    )
                                }
                                
                                // WhatsApp Button
                                Button(action: {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                    shareToWhatsApp()
                                }) {
                                    HStack {
                                        Image(systemName: "message.fill")
                                        Text("WhatsApp")
                                    }
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 44)
                                    .background(Color.green.opacity(0.8))
                                    .cornerRadius(22)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Spacer(minLength: 40)
                    }
                    .padding(.horizontal, 20)
                }
                .refreshable {
                    await quoteManager.fetchNewQuoteAsync()
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showingShareSheet) {
            ShareSheet(items: [shareText()])
        }
        .alert("Copied!", isPresented: $showingCopiedAlert) {
            Button("OK") { }
        } message: {
            Text("Quote copied to clipboard")
        }
        .onAppear {
            if quoteManager.currentQuote.text.isEmpty {
                quoteManager.fetchNewQuote()
            }
        }
    }
    
    private func copyQuoteToClipboard() {
        UIPasteboard.general.string = shareText()
        showingCopiedAlert = true
    }
    
    private func shareToWhatsApp() {
        let urlWhats = "whatsapp://send?text=\(shareText().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let whatsappURL = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(whatsappURL) {
                UIApplication.shared.open(whatsappURL)
            } else {
                // WhatsApp not installed, fallback to regular share
                showingShareSheet = true
            }
        }
    }
    
    private func shareText() -> String {
        let quote = quoteManager.currentQuote
        return "\"\(quote.text)\"\n\n- \(quote.author)\n\nShared from Daily Quotes App"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}