import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:it126_registration/main.dart';

void main() {
  testWidgets('Register button stays disabled until the form is valid', (
    tester,
  ) async {
    await tester.pumpWidget(const PetalRegistrationApp());

    final registerButton = find.widgetWithText(FilledButton, 'Register');
    expect(registerButton, findsOneWidget);
    expect(tester.widget<FilledButton>(registerButton).onPressed, isNull);

    final fields = find.byType(TextFormField);
    expect(fields, findsNWidgets(5));
    await tester.enterText(fields.at(0), 'Jase');
    await tester.enterText(fields.at(1), 'Zerrudo');
    await tester.enterText(fields.at(2), 'jase@gmail.com');
    await tester.enterText(fields.at(3), 'secret123');
    await tester.enterText(fields.at(4), 'secret123');
    await tester.pump();

    expect(tester.widget<FilledButton>(registerButton).onPressed, isNotNull);
  });
}
