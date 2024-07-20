// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:attendance_app/main.dart';

void main() {
  testWidgets('Login button navigates to Home screen', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(AttendanceApp());

    // Verify the Login button is present.
    expect(find.text('Login'), findsOneWidget);

    // Tap the Login button and trigger a frame.
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify that we are on the Home screen.
    expect(find.text('Take Attendance'), findsOneWidget);
  });

  testWidgets('Take Attendance button navigates to Attendance screen', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(AttendanceApp());

    // Tap the Login button and trigger a frame.
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify the Take Attendance button is present.
    expect(find.text('Take Attendance'), findsOneWidget);

    // Tap the Take Attendance button and trigger a frame.
    await tester.tap(find.text('Take Attendance'));
    await tester.pumpAndSettle();

    // Verify that we are on the Attendance screen.
    expect(find.text('Attendance'), findsOneWidget);
  });
}