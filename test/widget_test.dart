import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_task_manager_app/main.dart';

void main() {
  testWidgets('Task Manager app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is displayed
    expect(find.text('Task Manager'), findsWidgets);

    // Verify that the FAB is present
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Tap the FAB and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that the add task screen is displayed
    expect(find.text('Add Task'), findsWidgets);
  });
}
