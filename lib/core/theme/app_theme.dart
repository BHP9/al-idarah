import 'package:flutter/material.dart';
class AppTheme {
  static const _seed = Color(0xFF1E6F5C);
  static ThemeData get light => ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: _seed));
  static ThemeData get dark => ThemeData(useMaterial3: true, brightness: Brightness.dark, colorScheme: ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.dark));
}
