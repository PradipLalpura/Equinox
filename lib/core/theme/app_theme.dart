import 'package:flutter/material.dart';

// EQUINOX design tokens (§39–40). Single source of truth.
abstract class EqColors {
  static const bg = Color(0xFFF7F8FC);
  static const card = Color(0xFFFFFFFF);
  static const primary = Color(0xFF5B5CE2);
  static const ink = Color(0xFF17181C);
  static const secondary = Color(0xFF70727A);
  static const success = Color(0xFF20B26B);
  static const warning = Color(0xFFF3A83B);
  static const error = Color(0xFFE05252);
}

ThemeData equinoxTheme() {
  final scheme =
      ColorScheme.fromSeed(
        seedColor: EqColors.primary,
        brightness: Brightness.light,
      ).copyWith(
        primary: EqColors.primary,
        surface: EqColors.card,
        error: EqColors.error,
      );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: EqColors.bg,
    cardTheme: const CardThemeData(
      color: EqColors.card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        side: BorderSide(color: Color(0xFFE9EAF0)),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: EqColors.ink,
        letterSpacing: -1,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: EqColors.ink,
        letterSpacing: -0.5,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: EqColors.ink,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: EqColors.ink,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: EqColors.ink),
      bodyMedium: TextStyle(fontSize: 14, color: EqColors.secondary),
    ),
  );
}
