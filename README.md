# IQDED - Intelligent Quiz Delivery & Education Dashboard

A Flutter-based quiz application that delivers personalized educational content with offline capabilities and intelligent question generation.

## 🚀 Features

### Core Functionality
- **AI-Powered Question Generation**: Leverages Firebase AI (Gemini 1.5 Flash) to generate contextual quiz questions
- **Offline-First Architecture**: Questions are cached locally using Hive for seamless offline access
- **Smart Question History**: Prevents repetition by tracking previously asked questions
- **Category-Based Learning**: Supports multiple subject categories with difficulty levels
- **Clean Architecture**: Implements Clean Architecture principles with proper separation of concerns

### Technical Highlights
- **State Management**: BLoC pattern for predictable state management
- **Local Storage**: Hive database for efficient offline data persistence
- **Dependency Injection**: Modular architecture with proper dependency injection
- **Error Handling**: Comprehensive error handling with graceful fallbacks
- **Connectivity Management**: Smart network detection with automatic offline fallback

## 🏗️ Architecture

The project follows **Clean Architecture** principles with clear separation between layers:

```
lib/
├── core/
│   ├── database/
│   │   └── hive_types.dart          # Hive type definitions
│   └── error/
│       ├── exceptions.dart          # Custom exception classes
│       └── failure.dart            # Failure handling
├── features/
│   └── quizPage/
│       ├── data/
│       │   ├── dataSources/
│       │   │   ├── questions_local_data_source.dart
│       │   │   └── questions_remote_data_source.dart
│       │   ├── models/
│       │   │   ├── question_model.dart
│       │   │   └── questions_model.dart
│       │   └── repositories/
│       │       └── questions_repository_impl.dart
│       ├── domain/
│       │   ├── entity/
│       │   │   ├── question_entity.dart
│       │   │   └── questions_entity.dart
│       │   ├── repositories/
│       │   │   └── questions_repository.dart
│       │   └── usecases/
│       │       └── fetch_questions.dart
│       └── presentation/
│           └── bloc/
│               └── questions_bloc.dart
```

## 🛠️ Tech Stack

- **Framework**: Flutter
- **State Management**: BLoC (Business Logic Component)
- **Local Database**: Hive
- **AI Integration**: Firebase AI (Gemini 1.5 Flash)
- **Networking**: HTTP with connectivity detection
- **Architecture**: Clean Architecture with Repository Pattern
- **Dependency Injection**: GetIt (implied from architecture)

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  hive_ce: ^3.0.0
  hive_ce_flutter: ^3.0.0
  firebase_ai: ^0.1.0
  connectivity_plus: ^4.0.0
  fpdart: ^1.1.0
  bloc: ^8.1.0
  flutter_bloc: ^8.1.0

dev_dependencies:
  build_runner: ^2.4.0
  hive_ce_generator: ^2.0.0
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Firebase project with AI services enabled

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/iqded.git
   cd iqded
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Configure Firebase**
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Enable Firebase AI services in your Firebase console

5. **Run the app**
   ```bash
   flutter run
   ```

## 🔧 Configuration

### Hive Setup
The app uses Hive for local storage with custom type adapters. Make sure to register adapters in your `main.dart`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  
  // Register adapters
  Hive.registerAdapter(QuestionModelAdapter());
  Hive.registerAdapter(QuestionsModelAdapter());
  
  await Hive.openBox('questionsBox');
  
  runApp(MyApp());
}
```

### Firebase AI Configuration
Ensure your Firebase project has the Vertex AI API enabled and proper authentication configured.

## 🎯 Usage

### Fetching Questions
The app automatically:
1. Checks for internet connectivity
2. Fetches new questions from Firebase AI if online
3. Caches questions locally for offline access
4. Falls back to cached questions when offline
5. Maintains question history to avoid repetition

### Offline Functionality
- Questions are automatically cached after each successful fetch
- App works seamlessly offline using cached data
- Smart fallback mechanism ensures continuous functionality

## 🔍 Key Components

### Data Sources
- **Remote Data Source**: Handles AI-powered question generation via Firebase
- **Local Data Source**: Manages Hive database operations for offline storage

### Repository Pattern
- Abstracts data sources behind a clean interface
- Handles online/offline logic transparently
- Implements proper error handling and fallback mechanisms

### BLoC State Management
- Manages UI state predictably
- Handles loading, success, and error states
- Provides reactive updates to the UI

## 🐛 Troubleshooting

### Common Issues

1. **Hive Adapter Registration Error**
   ```
   HiveError: Cannot write, unknown type: QuestionsModel
   ```
   **Solution**: Ensure adapters are registered before opening boxes

2. **Network Connectivity Issues**
   ```
   SocketException: Failed host lookup
   ```
   **Solution**: The app automatically falls back to cached questions

3. **Build Runner Issues**
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

Thanks to myself and my online friends for guiding me.

**Built with ❤️ using Flutter**
