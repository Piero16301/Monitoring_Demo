// Ignore for testing purposes
// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_demo/app/app.dart';
import 'package:monitoring_demo/login/login.dart';

void main() {
  group('App', () {
    testWidgets('renders LoginPage', (tester) async {
      await tester.pumpWidget(App());
      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
