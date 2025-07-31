import Foundation
import Combine
import SwiftUI
class QuoteManager: ObservableObject {
    @Published var currentQuote = Quote(text: "Welcome to Daily Quotes!", author: "Get inspired daily")
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    private let quotesURL = "https://type.fit/api/quotes"
    
    func fetchNewQuote() {
        isLoading = true
        
        guard let path = Bundle.main.path(forResource: "quotes", ofType: "json") else {
            handleError("Local file not found.")
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let quotes = try JSONDecoder().decode([QuoteResponse].self, from: data)
            processQuotes(quotes)
        } catch {
            handleError("Could not decode local quotes: \(error.localizedDescription)")
        }
        
        isLoading = false
    }

    
    func fetchNewQuoteAsync() async {
        await MainActor.run {
            isLoading = true
        }
        
        do {
            guard let url = URL(string: quotesURL) else {
                await handleErrorAsync("Invalid URL")
                return
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let quotes = try JSONDecoder().decode([QuoteResponse].self, from: data)
            
            await MainActor.run {
                self.processQuotes(quotes)
                self.isLoading = false
            }
        } catch let decodingError as DecodingError {
            print("Decoding Error: \(decodingError)")
            await handleErrorAsync(decodingError.localizedDescription)
        } catch {
            await handleErrorAsync(error.localizedDescription)
        }

    }
    
    private func processQuotes(_ quotes: [QuoteResponse]) {
        guard !quotes.isEmpty else {
            handleError("No quotes available")
            return
        }
        
        let randomQuote = quotes.randomElement()!
        let cleanText = randomQuote.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanAuthor = (randomQuote.author ?? "Unknown").trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Add subtle animation when updating quote
        withAnimation(.easeInOut(duration: 0.5)) {
            currentQuote = Quote(
                text: cleanText.isEmpty ? "Every moment is a fresh beginning." : cleanText,
                author: cleanAuthor.isEmpty ? "Unknown" : cleanAuthor
            )
        }
    }
    
    private func handleError(_ message: String) {
        print("Quote fetch error: \(message)")
        withAnimation(.easeInOut(duration: 0.3)) {
            currentQuote = Quote(
                text: "Every moment is a fresh beginning.",
                author: "T.S. Eliot"
            )
        }
    }
    
    private func handleErrorAsync(_ message: String) async {
        print("Quote fetch error: \(message)")
        await MainActor.run {
            withAnimation(.easeInOut(duration: 0.3)) {
                self.currentQuote = Quote(
                    text: "Every moment is a fresh beginning.",
                    author: "T.S. Eliot"
                )
                self.isLoading = false
            }
        }
    }
}

struct QuoteResponse: Codable {
    let text: String
    let author: String?
}

struct Quote {
    let text: String
    let author: String
}
