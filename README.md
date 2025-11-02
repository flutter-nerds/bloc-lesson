# 🌍 Flutter BLoC Lesson - Country Search App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![BLoC](https://img.shields.io/badge/BLoC-000000?style=for-the-badge&logo=flutter&logoColor=white)

**A comprehensive Flutter project demonstrating BLoC pattern implementation for state management**

[Features](#-features) • [Architecture](#-architecture) • [Getting Started](#-getting-started) • [Project Structure](#-project-structure) • [Learning Points](#-learning-points)

</div>

---

## 📖 About

This project is a practical learning resource for understanding the **BLoC (Business Logic Component)** pattern in Flutter. It demonstrates how to implement clean architecture, separation of concerns, and reactive state management by building a real-world country search application that fetches data from the REST Countries API.

## ✨ Features

- 🔍 **Real-time Country Search** - Search for countries using REST Countries API
- 🎯 **BLoC Pattern Implementation** - Complete separation of business logic from UI
- 🌐 **API Integration** - HTTP requests using Dio package
- 🎨 **Clean Architecture** - Well-organized code structure
- ⚡ **Reactive State Management** - Handle loading, success, and error states
- 🛡️ **Error Handling** - Custom exception classes for robust error management
- 📱 **Material Design UI** - Beautiful and intuitive user interface

## 🏗️ Architecture

This project follows the **BLoC pattern** with clean architecture principles:

```
┌─────────────┐
│     UI      │  ← Presentation Layer (Widgets)
└──────┬──────┘
       │
┌──────▼──────┐
│    BLoC     │  ← Business Logic Layer (State Management)
└──────┬──────┘
       │
┌──────▼──────┐
│  Services   │  ← Data Layer (API Calls)
└──────┬──────┘
       │
┌──────▼──────┐
│  Models     │  ← Data Models
└─────────────┘
```

### State Flow Diagram

```
User Input (Search)
        │
        ▼
┌───────────────────┐
│ SearchCountryEvent│
└─────────┬─────────┘
          │
          ▼
┌─────────────────┐
│ CountryBlocBloc │
└────────┬────────┘
         │
         ├──► CountryBlocLoading
         │
         ├──► CountryBlocLoaded(countries)
         │
         └──► CountryBlocError(message)
```

## 📂 Project Structure

```
lib/
├── main.dart                          # Application entry point
├── blocs/
│   └── country_bloc/
│       ├── country_bloc_bloc.dart     # BLoC logic implementation
│       ├── country_bloc_event.dart    # BLoC events
│       └── country_bloc_state.dart    # BLoC states
├── exceptions/
│   └── app_exception.dart             # Custom exception classes
├── models/
│   ├── country_model.dart             # Country data model
│   ├── country_name_model.dart        # Country name model
│   ├── country_native_name.dart       # Native name model
│   └── locale_name_model.dart         # Locale name model
├── screens/
│   └── home_page.dart                 # Main application screen
├── services/
│   └── api_service.dart               # API communication layer
└── widgets/                           # Reusable widgets
```

## 🎓 Learning Points

### 1. **BLoC Pattern**
- **Events**: User actions that trigger state changes
- **States**: Different UI states (Initial, Loading, Loaded, Error)
- **Bloc**: Business logic that processes events and emits states

```dart
// Event triggers state changes
context.read<CountryBlocBloc>().add(
  SearchCountryEvent(searchText: searchText),
);

// BLoC processes event and emits new state
emit(CountryBlocLoading());
emit(CountryBlocLoaded(countries: countries));
```

### 2. **State Management**
Four distinct states for clean UI rendering:
- `CountryBlocInitial` - App just started
- `CountryBlocLoading` - Fetching data from API
- `CountryBlocLoaded` - Data successfully loaded
- `CountryBlocError` - Error occurred during fetch

### 3. **Error Handling**
Custom exception hierarchy for better error management:
- `AppException` - Base exception class
- `ApiException` - HTTP/API related errors
- `ParseException` - JSON parsing errors
- `UnknownException` - Unexpected errors

### 4. **API Integration**
Using Dio for HTTP requests with proper error handling:
```dart
final response = await dio.get(
  'https://restcountries.com/v3.1/name/$searchText',
);
```

### 5. **Reactive UI**
Using `BlocBuilder` to rebuild UI based on state changes:
```dart
BlocBuilder<CountryBlocBloc, CountryBlocState>(
  builder: (context, state) {
    if (state is CountryBlocLoading) return CircularProgressIndicator();
    if (state is CountryBlocError) return Text(state.message);
    if (state is CountryBlocLoaded) return ListView(...);
    return Text('Initial state');
  },
)
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.9.0 or higher)
- Dart SDK
- IDE (VS Code, Android Studio, or IntelliJ IDEA)

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repository-url>
   cd bloc_lesson
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## 📦 Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_bloc` | ^9.1.1 | BLoC state management |
| `bloc` | ^9.1.0 | Core BLoC library |
| `dio` | ^5.9.0 | HTTP client for API calls |
| `cupertino_icons` | ^1.0.8 | iOS style icons |

## 🎯 How It Works

1. **User enters a country name** in the search field
2. **SearchCountryEvent is dispatched** when search button is pressed
3. **BLoC receives the event** and emits `CountryBlocLoading` state
4. **ApiService fetches data** from REST Countries API
5. **BLoC emits appropriate state**:
   - `CountryBlocLoaded` with country data on success
   - `CountryBlocError` with error message on failure
6. **UI updates automatically** based on the emitted state

## 🎨 UI Features

- **Search Bar**: Material Design text field with send icon
- **Loading Indicator**: Shows circular progress indicator during API calls
- **Country List**: Displays country information in a scrollable list
- **Error Display**: Shows user-friendly error messages
- **Country Details**: 
  - Official name
  - Capital city
  - Region
  - Native names in different locales

## 🔧 Customization

### Adding New Features

1. **New Events**: Add to `country_bloc_event.dart`
2. **New States**: Add to `country_bloc_state.dart`
3. **Event Handlers**: Implement in `country_bloc_bloc.dart`
4. **UI Updates**: Modify `home_page.dart`

### API Endpoints

The app uses [REST Countries API](https://restcountries.com/):
- Base URL: `https://restcountries.com/v3.1`
- Endpoint: `/name/{country_name}`

## 🐛 Error Handling Examples

```dart
// API Error (Network issues, 404, etc.)
catch (e) on DioException {
  throw ApiException(
    statusCode: e.response?.statusCode,
    message: e.message,
  );
}

// Parsing Error (Invalid JSON structure)
catch (e) {
  throw ParseException(
    message: 'error on parsing CountryModel'
  );
}

// Unknown Error (Unexpected issues)
catch (e) {
  throw UnknownException();
}
```

## 📚 Additional Resources

- [Flutter BLoC Documentation](https://bloclibrary.dev/)
- [Flutter Documentation](https://flutter.dev/docs)
- [REST Countries API](https://restcountries.com/)
- [Dio Package](https://pub.dev/packages/dio)

## 🎓 Key Takeaways

After completing this project, you will understand:

✅ How to implement BLoC pattern in Flutter  
✅ Separation of concerns and clean architecture  
✅ Reactive state management  
✅ API integration with error handling  
✅ Custom exception handling  
✅ Building responsive UIs with BlocBuilder  
✅ Proper project structure and organization  

## 🤝 Contributing

This is a learning project! Feel free to:
- Add new features
- Improve error handling
- Enhance UI/UX
- Add unit tests
- Improve documentation

## 📝 License

This project is created for educational purposes.

---

<div align="center">

**Built with ❤️ using Flutter & BLoC**

⭐ Star this repo if you found it helpful!

</div>
# bloc-lesson
