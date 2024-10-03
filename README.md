# SimpleCoreData

A simple iOS application using Core Data to manage company and employee check-ins. The app demonstrates the usage of Core Data with Swift, including repository patterns, coordinator patterns, async/await network requests, and SwiftUI for the UI layer. It also integrates **Objective-C** for certain components, showcasing how to handle mixed-language projects in a modern iOS application.

## Features

- **MVVM Architecture**: The app follows the **Model-View-ViewModel (MVVM)** pattern to separate the business logic from the UI, allowing for clean and maintainable code.
- **Core Data**: The app uses Core Data to store and manage entities like `Company` and `Employee`.
- **Repository Pattern**: For clean data access and separation of concerns, repositories manage interactions with the Core Data layer.
- **Coordinator Pattern**: Navigation flow is handled using a Coordinator pattern to improve scalability and decouple navigation logic.
- **Networking**: Mock networking service to simulate remote data fetching via `async/await`.
- **SwiftUI Integration**: SwiftUI is used for a smooth and modern user interface, integrated into a traditional UIKit project.
- **Objective-C Integration**: Demonstrates how to integrate Objective-C with Swift, including bridging headers and Objective-C compatibility in a Swift project.
- **Unit Tests**: Tests are written using **Quick** and **Nimble** to ensure the correctness of the ViewModels and business logic.