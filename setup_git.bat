@echo off
REM Initialize git repository
cd /d c:\Users\malla\Desktop\TaskManager\flutter_task_manager_app

git init
git config user.email "ajaymallak2740@gmail.com"
git config user.name "Ajay Mallak"

REM Commit 1: Initial setup with theme and folder structure
echo Adding initial setup files...
git add pubspec.yaml analysis_options.yaml .gitignore lib/main.dart lib/utils/theme.dart lib/utils/constants.dart
git commit -m "feat: initial setup with theme and folder structure"

REM Commit 2: Task model with Hive adapter
echo Adding task model...
git add lib/models/task_model.dart lib/services/hive_service.dart
git commit -m "feat: add task model with hive adapter"

REM Commit 3: Providers with CRUD logic
echo Adding providers...
git add lib/providers/task_provider.dart lib/providers/theme_provider.dart
git commit -m "feat: add provider with CRUD logic"

REM Commit 4: UI screens and widgets with validation
echo Adding UI components...
git add lib/screens/ lib/widgets/
git commit -m "feat: build home and add-edit UI with validation"

REM Commit 5: Polish, search, filter, and README
echo Adding README and test...
git add README.md test/widget_test.dart
git commit -m "feat: add search, filter, theme switch + offline persistence + README"

git log --oneline

echo Done! Ready to push to GitHub.
