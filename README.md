# Flutter Task Manager App

A production-ready task management application built with Flutter, showcasing modern mobile app architecture, state management best practices, and offline-first design. This project demonstrates the exact architecture recruiters want to see in Flutter portfolios.

## ✨ Features

- ✅ **Full CRUD Operations** - Create, read, update, and delete tasks seamlessly
- ✅ **Task Prioritization** - Assign Low/Medium/High priority levels to tasks
- ✅ **Status Tracking** - Mark tasks as Pending or Done with visual indicators
- ✅ **Advanced Search** - Real-time search across task titles and descriptions
- ✅ **Smart Filtering** - Filter by status (Pending/Done) or priority levels
- ✅ **Offline First** - Full app functionality works without internet using Hive local database
- ✅ **Dark/Light Theme** - Beautiful Material 3 theme switcher
- ✅ **Form Validation** - Comprehensive input validation for data integrity
- ✅ **Responsive UI** - Optimized for mobile phones and tablets
- ✅ **Intuitive UX** - Clean, modern interface with smooth animations

## 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| **Flutter 3.24+** | Cross-platform mobile framework |
| **Dart 3.0+** | Programming language |
| **Provider 6.0+** | State management (MVVM pattern) |
| **Hive 2.2+** | Local NoSQL database (offline persistence) |
| **Material 3** | Modern UI design system |
| **Intl** | Date/time localization |
| **UUID** | Unique ID generation |

## 📁 Folder Structure

```
lib/
├── main.dart                          # App entry point
├── models/
│   └── task_model.dart               # Task data model (Hive entity)
├── providers/
│   ├── task_provider.dart            # Business logic + CRUD operations
│   └── theme_provider.dart           # Theme state management
├── screens/
│   ├── home_screen.dart              # Main task list + search/filter
│   └── add_edit_task_screen.dart     # Form for creating/editing tasks
├── widgets/
│   ├── task_card.dart                # Reusable task list item
│   ├── priority_chip.dart            # Priority display component
│   └── custom_textfield.dart         # Reusable text input widget
├── services/
│   └── hive_service.dart             # Database initialization + CRUD helpers
└── utils/
    ├── theme.dart                    # Light/Dark theme definitions
    └── constants.dart                # App-wide constants & enums
```

## 🏗️ Architecture Overview

### MVVM + Clean Architecture Pattern

```
UI Layer (Screens + Widgets)
        ↓
State Management Layer (Provider)
        ↓
Business Logic (TaskProvider)
        ↓
Data Layer (HiveService + Task Model)
        ↓
Local Database (Hive)
```

**Why this architecture?**
- **Separation of Concerns**: UI, business logic, and data are clearly separated
- **Testability**: Each layer can be tested independently
- **Maintainability**: Easy to modify features without touching other layers
- **Scalability**: Simple to add new features or integrate APIs

### Key Components

#### Models (`task_model.dart`)
- Uses Hive annotations (`@HiveType`, `@HiveField`) for persistence
- Includes `copyWith()` for immutable updates
- Clean toString() for debugging

#### Providers (`*_provider.dart`)
- **TaskProvider**: Manages all task operations (CRUD, filtering, searching)
- **ThemeProvider**: Manages light/dark theme state
- Both extend `ChangeNotifier` for reactive updates

#### Services (`hive_service.dart`)
- Centralized database access
- Handles Hive initialization and box management
- Provides type-safe CRUD operations

## ⚡ Quick Start

### Prerequisites
- Flutter SDK 3.24.0 or higher
- Dart 3.0 or higher
- Android Studio, Xcode, or VS Code with Flutter extension

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ajaymallak2740/flutter_task_manager_app.git
   cd flutter_task_manager_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters**
   ```bash
   flutter pub run build_runner build
   ```
   Or use `build_runner` watch mode for continuous generation:
   ```bash
   flutter pub run build_runner watch
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### For Web Demo
```bash
flutter run -d chrome
```

### For Tablet Emulator
```bash
flutter run -d <emulator-id> --device-id=<emulator-id>
```

## 📱 Screens

### Home Screen
- Display all tasks in a scrollable list
- Search bar for real-time filtering
- Filter chips for Status and Priority
- Swipe actions for quick edit/delete
- FAB (Floating Action Button) to create new task

**Responsive Features:**
- Mobile: Single column layout with material design
- Tablet: Optimized spacing and larger hit targets

### Add/Edit Task Screen
- Form validation for title (required, min 3 chars)
- Rich text area for descriptions
- Priority dropdown selector
- Date picker for due dates
- Material 3 input styling
- Success/error snackbar feedback

## 🎨 Dark Mode

Switch between light and dark themes with one tap:
- Material 3 color system automatically adapts
- Smooth theme transitions
- Persistent theme preference (implements local storage in future versions)

## 🧪 Code Quality

### Validation
- Form validation on user input
- Task title required and minimum length
- Date validation (due date can't be in the past)

### Best Practices
- No `setState()` outside of State widgets
- Proper lifecycle management (dispose)
- Memory-efficient list rendering with ListView.builder
- Proper error handling and user feedback

## 🚀 Performance Optimizations

- **Lazy Loading**: Lists use `ListView.builder` for memory efficiency
- **Selective Rebuilds**: Use of `Consumer<T>` and `context.select()` to minimize rebuilds
- **Local Storage**: Hive provides instant data access without network latency
- **Async Operations**: All database operations are asynchronous

## 🔄 State Management Flow

```
User Action (Tap, Input, etc.)
        ↓
Provider Method Called (e.g., addTask())
        ↓
Database Operation (Hive Save/Update)
        ↓
notifyListeners()
        ↓
Affected Widgets Rebuild
```

## 📊 Database Schema

### Task Entity (Hive)
```dart
@HiveType(typeId: 0)
class Task {
  @HiveField(0) String id;              // UUID
  @HiveField(1) String title;           // Task name
  @HiveField(2) String description;     // Task details
  @HiveField(3) String priority;        // 'low', 'medium', 'high'
  @HiveField(4) DateTime dueDate;       // Deadline
  @HiveField(5) bool isDone;            // Completion status
  @HiveField(6) DateTime createdAt;     // Creation timestamp
}
```

## 🔧 How to Extend

### Adding a New Feature

**Example: Task Categories**

1. **Update Model** (`task_model.dart`)
   ```dart
   @HiveField(7) String category;
   ```

2. **Update Provider** (`task_provider.dart`)
   ```dart
   void filterByCategory(String category) {
     _filterCategory = category;
     notifyListeners();
   }
   ```

3. **Update UI** (Add category dropdown to `add_edit_task_screen.dart`)

4. **Regenerate Adapters**
   ```bash
   flutter pub run build_runner build
   ```

### Integrating a Backend API

1. Create a `repositories/` folder
2. Add API service class (e.g., `TaskRepository`)
3. Update provider to call repository instead of HiveService
4. Implement sync/offline-sync pattern

## 📸 Screenshots

### Light Mode
- **Home Screen**: Task list with search and filters
- **Add Task**: Clean form with validation
- **Dark Mode**: Beautiful Material 3 dark theme

*Demo GIF and screenshots can be added by running the app on an emulator and recording screen capture.*

## ✅ Testing

Basic widget test included to verify app launches correctly:
```bash
flutter test
```

## 🤝 Contributing

This is a portfolio project, but feel free to fork and customize!

## 📄 License

MIT License - feel free to use this project as a template for your portfolio

## 👨‍💻 Author

**Ajay Mallak** - Flutter Developer
- GitHub: [@ajaymallak2740](https://github.com/ajaymallak2740)

## 🎯 Why This Project Stands Out

1. **Production-Ready Code**: Clean, well-organized, follows Flutter best practices
2. **State Management**: Demonstrates proper Provider usage without setState hell
3. **Offline-First Architecture**: Uses Hive for bulletproof local persistence
4. **Responsive Design**: Works seamlessly on mobile and tablets
5. **Reusable Components**: Custom widgets avoid code duplication
6. **Form Validation**: Comprehensive input validation with UX feedback
7. **Modern UI**: Material 3 design system with dark mode support
8. **Code Organization**: Clear separation of concerns with MVVM pattern

---

**🎓 Perfect for:**
- Portfolio projects for Flutter developers
- Interview prep (architecture, state management, database)
- Learning production Flutter patterns
- Template for task-based apps (todos, projects, etc.)

## 📞 Support

For questions or suggestions, open an issue on GitHub!

---

⭐ If this project helps you, please give it a star!
