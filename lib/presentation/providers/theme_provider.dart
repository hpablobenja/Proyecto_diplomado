// lib/presentation/providers/theme_provider.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';

  ThemeMode _themeMode = ThemeMode.light;
  bool _isLoading = false;

  ThemeMode get themeMode => _themeMode;
  bool get isLoading => _isLoading;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  ThemeProvider() {
    _loadThemeMode();
  }

  // Load theme mode from SharedPreferences
  Future<void> _loadThemeMode() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt(_themeKey) ?? 0;
      _themeMode = ThemeMode.values[themeIndex];
    } catch (e) {
      // Fallback to light mode if there's an error
      _themeMode = ThemeMode.light;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Save theme mode to SharedPreferences
  Future<void> _saveThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, _themeMode.index);
    } catch (e) {
      // Handle error silently
      debugPrint('Error saving theme mode: $e');
    }
  }

  // Toggle between light and dark mode
  Future<void> toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _saveThemeMode();
    notifyListeners();
  }

  // Set specific theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode != mode) {
      _themeMode = mode;
      await _saveThemeMode();
      notifyListeners();
    }
  }

  // Set light mode
  Future<void> setLightMode() async {
    await setThemeMode(ThemeMode.light);
  }

  // Set dark mode
  Future<void> setDarkMode() async {
    await setThemeMode(ThemeMode.dark);
  }

  // Set system mode
  Future<void> setSystemMode() async {
    await setThemeMode(ThemeMode.system);
  }

  // Get theme mode string for UI
  String getThemeModeString() {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Claro';
      case ThemeMode.dark:
        return 'Oscuro';
      case ThemeMode.system:
        return 'Sistema';
    }
  }

  // Get theme mode icon for UI
  IconData getThemeModeIcon() {
    switch (_themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }
}
