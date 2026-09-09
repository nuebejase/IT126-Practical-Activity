import 'package:flutter/material.dart';

/// Soft pink + sage green palette used across the registration UI.
/// Colors live in one place so the screen widgets stay focused on behavior.
class PetalColors {
  static const blush = Color(0xFFFFF1F5);
  static const petal = Color(0xFFF4B8C8);
  static const rose = Color(0xFFE07A9A);
  static const ink = Color(0xFF4A3040);
  static const sage = Color(0xFF8FBF9A);
  static const leaf = Color(0xFF5C8F6A);
  static const cream = Color(0xFFFFFBFA);
  static const mist = Color(0xFFE7F3EA);
}

class AppTheme {
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: PetalColors.rose,
      primary: PetalColors.rose,
      secondary: PetalColors.leaf,
      surface: PetalColors.cream,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: PetalColors.blush,
      fontFamily: 'Segoe UI',
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: PetalColors.cream,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        labelStyle: const TextStyle(color: PetalColors.ink),
        hintStyle: TextStyle(color: PetalColors.ink.withValues(alpha: 0.45)),
        prefixIconColor: PetalColors.leaf,
        suffixIconColor: PetalColors.rose,
        border: _outline(PetalColors.petal.withValues(alpha: 0.7)),
        enabledBorder: _outline(PetalColors.sage.withValues(alpha: 0.55)),
        focusedBorder: _outline(PetalColors.rose, width: 2),
        errorBorder: _outline(PetalColors.rose),
        focusedErrorBorder: _outline(PetalColors.rose, width: 2),
      ),
    );
  }

  static OutlineInputBorder _outline(Color color, {double width = 1.2}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
