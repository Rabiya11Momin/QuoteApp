# Daily Quotes iOS App

A beautiful iOS app built with SwiftUI that delivers inspiring daily quotes with sharing capabilities.

## Features

- 📱 **Native iOS Experience**: Built with SwiftUI following Apple's Human Interface Guidelines
- 🔄 **Random Quotes**: Fetches inspiring quotes from the type.fit API
- ⚡ **Instant Loading**: Smooth animations and loading states
- 📋 **Copy to Clipboard**: Quick copy functionality with user feedback
- 🔗 **Share Anywhere**: Native iOS sharing to any app or service
- 💬 **WhatsApp Integration**: Direct sharing to WhatsApp with fallback
- 🎨 **Beautiful Design**: Gradient backgrounds, glassmorphism effects, and micro-interactions
- 📱 **Responsive**: Works perfectly on all iPhone sizes
- 🔄 **Pull to Refresh**: Pull down to get a new quote

## Technical Implementation

### Architecture
- **MVVM Pattern**: Using `@StateObject` and `ObservableObject`
- **Combine Framework**: For reactive data flow and API calls
- **Async/Await**: Modern Swift concurrency for smooth UX
- **SwiftUI**: Latest UI framework with native iOS components

### Key Components

1. **ContentView**: Main app interface with gradient background and quote display
2. **QuoteCardView**: Reusable card component for displaying quotes with loading states
3. **QuoteManager**: Observable class handling API calls and state management
4. **ShareSheet**: UIKit bridge for native iOS sharing functionality

### API Integration
- Uses URLSession with Combine publishers
- Handles network errors gracefully with fallback quotes
- Implements both callback-based and async/await patterns
- JSON decoding with proper error handling

## Setup Instructions

1. **Create New Xcode Project**:
   - Open Xcode
   - Create new iOS app
   - Choose SwiftUI interface
   - Set minimum deployment target to iOS 15.0+

2. **Add Files**:
   - Copy all `.swift` files to your Xcode project
   - Replace the default `Info.plist` with the provided one
   - Ensure all files are added to your app target

3. **Configure Project**:
   - Set bundle identifier (e.g., com.yourname.dailyquotes)
   - Configure signing & capabilities
   - Add network permissions if needed

4. **Build and Run**:
   - Select your target device or simulator
   - Press Cmd+R to build and run

## Concepts Demonstrated

- **URLSession & Networking**: Modern Swift networking with error handling
- **Combine Framework**: Reactive programming patterns
- **SwiftUI State Management**: `@StateObject`, `@Published`, `@State`
- **Async/Await**: Modern Swift concurrency
- **UIKit Integration**: Bridging UIActivityViewController to SwiftUI
- **iOS Sharing**: Native share sheet and app-specific sharing
- **Haptic Feedback**: Tactile feedback for better UX
- **Animation**: SwiftUI animations and transitions

## Customization

### Colors & Styling
- Modify gradient colors in `ContentView`
- Adjust card styling in `QuoteCardView`
- Change button styles and spacing

### API Configuration
- Replace API URL in `QuoteManager`
- Add API key if using different quote service
- Modify quote processing logic

### Sharing Options
- Add more social media platforms
- Customize share text format
- Add image sharing capabilities

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## Permissions

The app requires:
- Network access for fetching quotes
- WhatsApp URL scheme (already configured in Info.plist)

## Future Enhancements

- Offline quote storage
- Favorite quotes collection
- Daily notifications
- Quote categories
- Custom backgrounds
- Dark mode support