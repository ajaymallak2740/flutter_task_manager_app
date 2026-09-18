# Quick Start Guide

## Prerequisites ✅
- Flutter SDK 3.24.0+ installed  
- Dart 3.0+ (comes with Flutter)
- Android Studio, Xcode, VS Code, or IntelliJ IDEA
- An emulator or physical device

## Installation (5 minutes)

### 1. Install Dependencies
```bash
cd flutter_task_manager_app
flutter pub get
```

Expected output:
```
Running "flutter pub get" in flutter_task_manager_app...
...
Running "flutter pub upgrade" in flutter_task_manager_app...
...
```

### 2. Generate Hive Adapters
```bash
flutter pub run build_runner build
```

Expected output:
```
[INFO] Generating build script completed, took 316ms with 0 errors
[INFO] There were no actions to run (nothing changed).
[INFO] Building package executable...
```

### 3. Verify Installation
```bash
flutter doctor
```

Should show all green checkmarks ✅ (at least Flutter SDK and one device)

## Running the App

### On Android Emulator
```bash
flutter emulators --launch Pixel_5_API_30
# Wait for emulator to fully load
flutter run
```

### On iOS Simulator (Mac only)
```bash
open -a Simulator
flutter run
```

### On Web (Chrome)
```bash
flutter run -d chrome
```

### On Physical Device
```bash
# Connect device via USB
flutter devices  # Verify your device appears
flutter run
```

## Testing the Features

Once the app launches, try:

1. **✅ Create Task**
   - Tap the blue FAB (+)
   - Enter title, description, priority, due date
   - Tap "Create Task"

2. **✅ View Task**
   - See task in the list on Home screen
   - Priority shown as colored chip (Red=High, Orange=Medium, Green=Low)

3. **✅ Edit Task**
   - Long-press or tap menu on a task card
   - Tap "Edit"
   - Modify fields and tap "Update Task"

4. **✅ Mark as Done**
   - Check the checkbox on any task
   - Task title will have strikethrough

5. **✅ Search**
   - Type in the search bar
   - Tasks filter in real-time

6. **✅ Filter**
   - Tap filter chips: "All", "Pending", "Done", "High", "Medium", "Low"
   - List updates instantly

7. **✅ Delete Task**
   - Tap menu (⋮) on a task
   - Tap "Delete"

8. **✅ Theme Toggle**
   - Tap sun/moon icon in AppBar
   - App switches between light and dark themes

9. **✅ Offline Test**
   - Add a few tasks
   - Close and force-close the app
   - Reopen app
   - Tasks are still there! ✅ (Offline persistence works)

## File Location

All code is in `lib/` folder:
```
lib/main.dart                  ← Start here
lib/screens/home_screen.dart   ← Main UI
lib/models/task_model.dart     ← Data structure
lib/providers/task_provider.dart ← Business logic
```

## Common Issues & Solutions

### Issue: "Flutter not found"
**Solution**: 
```bash
echo $env:PATH  # Check if flutter/bin is in PATH
flutter doctor  # Verify Flutter installation
```

### Issue: "Dart SDK not found"
**Solution**: 
```bash
flutter upgrade
```

### Issue: Hive adapter not generated
**Solution**:
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue: App crashes on startup
**Solution**:
```bash
flutter run --verbose  # See detailed logs
# Check that Hive is initialized in main.dart before runApp()
```

### Issue: UI looks different / doesn't match Material 3
**Solution**:
- App uses Material 3 (requires recent Flutter)
- Update Flutter: `flutter upgrade`

## Development Tips

### Hot Reload
```bash
r  # Press 'r' in terminal to hot reload
# Code changes appear instantly (without app restart)
```

### Hot Restart
```bash
R  # Press 'R' in terminal for full app restart
```

### View Logs
```bash
flutter logs
```

### Run Tests
```bash
flutter test
```

### Profile App Performance
```bash
flutter run --profile
```

## Next Steps

1. **Explore Code**: Read through `lib/main.dart` → understand the flow
2. **Modify UI**: Change colors in `lib/utils/theme.dart`
3. **Add Features**: Add a category field to the Task model
4. **Push to GitHub**: See `PROJECT_GUIDE.md`
5. **Deploy**: Build release APK/App Bundle

## Useful Commands

| Command | Purpose |
|---------|---------|
| `flutter pub get` | Install deps |
| `flutter pub upgrade` | Update deps |
| `flutter run` | Launch app |
| `flutter build apk` | Build Android APK |
| `flutter build ios` | Build iOS app |
| `flutter clean` | Clear build cache |
| `flutter analyze` | Check code quality |
| `flutter test` | Run tests |

## Performance Tips

- Use `flutter run --release` for production-speed testing
- Check "Show performance overlay" in dev menu (press 'P')
- Profile with `flutter run --profile`

---

**Stuck?** Check the README.md or ARCHITECTURE.md for more details!
