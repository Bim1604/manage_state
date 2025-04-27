🌱 Reactive State Package (Flutter)
A Flutter package for efficient state management without relying on external state management packages. It provides a simple and flexible way to manage both simple and complex state types with automatic UI updates when the state changes.

📱 User Interface

Main Screen: Demonstrates the usage of Reactive state management, updates UI when state changes, and uses Observer to reflect changes.

Performance Monitoring: Includes a performance monitor to track state change frequency and UI rebuilds.

State Management Example: A simple counter app that showcases the core features of the package.

🏗️ Architecture & Technologies

Component | Description
Reactive | State management for simple (e.g., integers) and complex (e.g., nested structures) data.
Computed | Automatically computes values based on dependencies (e.g., labels or derived data).
Observer | A widget that listens to reactive state and rebuilds only when the state changes.
Flutter | Native UI framework for Android & iOS
Dart | Primary programming language for business logic
flutter_test | For writing unit and widget tests

Overall Architecture: The package follows a simple and efficient design pattern:

Model: The data (e.g., counter, label) that is managed reactively.

View: The UI (Widgets) that reflects the changes when the model (state) changes.

Controller: For managing and updating the state (e.g., using Reactive and Computed).

⚙️ Setup
To install the `manage_state` package, add the following to your `pubspec.yaml` file:

yaml
dependencies:
  manage_state: ^1.0.5

flutter pub get

📦 Supported SDKs

Android: SDK 23 and above

iOS: iOS 11 and above

Flutter: Stable channel