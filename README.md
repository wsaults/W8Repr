# W8Repr

A modern iOS body weight rep logging application built with SwiftUI and SwiftData.

## Overview

W8Repr is a clean, intuitive body weight rep logging application that helps users track their bodyweight exercise repetitions over time. The app features a beautiful, modern UI with interactive charts and a comprehensive history view for your logged reps.

## Features

- 📊 Interactive rep logging charts
- 📅 Historical rep entry view
- ➕ Easy rep entry addition
- 🔄 Real-time data updates
- 💾 Persistent data storage using SwiftData
- 🎨 Modern, clean UI design

## Requirements

- iOS 18.0+
- Xcode 15.0+
- Swift 5.9+

## Installation

1. Clone the repository:
```bash
git clone https://github.com/wsaults/W8Repr.git
```

2. Open `W8Repr.xcodeproj` in Xcode

3. Build and run the project (⌘R)

## Project Structure

```
W8Repr/
├── W8Repr/              # Main app directory
│   ├── W8ReprApp.swift  # App entry point
│   ├── ContentView.swift  # Main view
│   └── Models/           # Data models
├── W8ReprTests/        # Unit tests
└── W8ReprUITests/      # UI tests
```

## Architecture

The app is built using:
- SwiftUI for the user interface
- SwiftData for data persistence
- Swift's latest features including Observation framework

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

Will Saults

## Acknowledgments

- Built with SwiftUI and SwiftData
- Charts powered by Swift Charts 
