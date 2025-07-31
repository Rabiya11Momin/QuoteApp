import SwiftUI

struct QuoteCardView: View {
    let text: String
    let author: String
    let isLoading: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            // Quote Icon
            Image(systemName: "quote.opening")
                .font(.system(size: 24))
                .foregroundColor(.blue.opacity(0.7))
                .opacity(isLoading ? 0.5 : 1.0)
            
            // Quote Text
            Text(text)
                .font(.title2)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .foregroundColor(.primary)
                .opacity(isLoading ? 0.5 : 1.0)
            
            // Author
            HStack {
                Rectangle()
                    .frame(width: 30, height: 1)
                    .foregroundColor(.secondary)
                
                Text(author)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                    .opacity(isLoading ? 0.5 : 1.0)
                
                Rectangle()
                    .frame(width: 30, height: 1)
                    .foregroundColor(.secondary)
            }
        }
        .padding(30)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.95))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .scaleEffect(isLoading ? 0.98 : 1.0)
        .animation(.easeInOut(duration: 0.3), value: isLoading)
        .overlay(
            // Loading overlay
            Group {
                if isLoading {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.clear)
                        .overlay(
                            ProgressView()
                                .scaleEffect(1.2)
                                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        )
                }
            }
        )
    }
}

struct QuoteCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            QuoteCardView(
                text: "The only way to do great work is to love what you do.",
                author: "Steve Jobs",
                isLoading: false
            )
            
            QuoteCardView(
                text: "Loading inspiring quote...",
                author: "Please wait",
                isLoading: true
            )
        }
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}