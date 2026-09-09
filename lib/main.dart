import 'package:flutter/material.dart';

import 'screens/registration_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const PetalRegistrationApp());
}

class PetalRegistrationApp extends StatelessWidget {
  const PetalRegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Petal Registration',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const RegistrationScreen(),
    );
  }
}
