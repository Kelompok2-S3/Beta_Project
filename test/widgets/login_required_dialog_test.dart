import 'package:beta_project/widgets/login_required_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LoginRequiredDialog renders correctly', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LoginRequiredDialog(),
        ),
      ),
    );

    // Allow animations to complete
    await tester.pumpAndSettle();

    // Verify that the title and message are displayed
    expect(find.text('Login Required'), findsOneWidget);
    expect(find.text('You need to be logged in to access your profile and settings.'), findsOneWidget);

    // Verify that the buttons are displayed
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    
    // Verify the icon is present (using IconData)
    expect(find.byIcon(Icons.lock_outline), findsOneWidget);
  });
}
