# Vizor - Your Pocket Viewfinder

<div align="center">

![vizor](https://github.com/egecam/Vizor/assets/23506587/01dee2e6-96e3-449d-9ae0-4a8088cd647c)

[![Swift Version](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

</div>

Vizor is a mobile application designed for photographers, developed for the iOS platform using Swift. It leverages both SwiftUI and UIKit for user interface development and uses Firebase as a cloud-based backend solution. Vizor adheres to Apple's Human Interface Guidelines.

## Features

- **SwiftUI and UIKit**: Utilized for creating a dynamic and responsive user interface.
- **Firebase**: Integrated for backend services.
- **SunKit**: Used for daylight-related astronomical calculations.
- **vFont**: Implements variable typefaces for enhanced typography.

## Getting Started

### Prerequisites

- iOS 13.0+
- Xcode 11+
- CocoaPods or Swift Package Manager for dependency management

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/Vizor.git
    cd Vizor
    ```
2. Install dependencies using CocoaPods:
    ```sh
    pod install
    ```
    Or using Swift Package Manager, open `Vizor.xcodeproj` and add the packages:
    - [Firebase iOS SDK](https://github.com/firebase/firebase-ios-sdk)
    - [SunKit](https://github.com/Sunlitt/SunKit)
    - [vFont](https://github.com/dufflink/vfont)

3. Open the `.xcworkspace` file in Xcode:
    ```sh
    open Vizor.xcworkspace
    ```

### Running the App

Build and run the app on your device or simulator from Xcode.

## Architecture

Vizor follows the Model-View-ViewModel (MVVM) pattern.

### Models

- **SunKit Manager**: Handles astronomical calculations related to daylight phases.
  - `getPhaseTimeList(location: CLLocation) -> [String: Date]`: Initializes a sun object and calculates times based on the location.
  - `calculatePhase(location: CLLocation) -> String`: Returns the current phase title based on location and time.

- **Location Manager**: Manages location authorization and user's location calculations.

## Contributing

Contributions are welcome! Please read the [contributing guidelines](CONTRIBUTING.md) for more details.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Firebase iOS SDK](https://github.com/firebase/firebase-ios-sdk)
- [SunKit](https://github.com/Sunlitt/SunKit)
- [vFont](https://github.com/dufflink/vfont)

---
