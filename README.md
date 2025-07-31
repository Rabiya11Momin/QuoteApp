
# 📚 Quote App (SwiftUI)

This is a simple inspirational Quote App built using SwiftUI and Combine. It loads quotes from a **local JSON file** and displays them with smooth animation.

---

## ✨ Features

- Display random inspirational quotes
- Quotes loaded from a local `quotes.json` file
- Uses Combine for data handling
- SwiftUI animations and reactive UI

---

## 📁 Project Structure

- `Quote.swift` – Model for Quote data
- `QuoteManager.swift` – Business logic and randomization
- `ContentView.swift` – Main UI
- `quotes.json` – Local JSON file with quotes

---

## 🛠️ How to Use

1. Clone or download the repo
2. Make sure `quotes.json` is included in your Xcode target
3. Run the app on iOS Simulator or a real device
4. Tap a button (if added) or observe automatic quote display

---

## 📄 Sample Quote Format

```json
[
  {
    "text": "Be yourself; everyone else is already taken.",
    "author": "Oscar Wilde"
  },
  {
    "text": "In three words I can sum up everything I've learned about life: it goes on.",
    "author": "Robert Frost"
  }
]

