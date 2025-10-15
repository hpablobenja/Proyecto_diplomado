// lib/presentation/providers/favorites_provider.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  static const _startedKey = 'started_course_ids';

  final Set<String> _startedCourseIds = {};
  bool _loaded = false;

  bool get isLoaded => _loaded;
  List<String> get startedCourseIds =>
      _startedCourseIds.toList(growable: false);

  Future<void> load() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_startedKey) ?? [];
    _startedCourseIds
      ..clear()
      ..addAll(ids);
    _loaded = true;
    notifyListeners();
  }

  Future<void> markCourseStarted(String courseId) async {
    _startedCourseIds.add(courseId);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_startedKey, _startedCourseIds.toList());
  }

  bool isCourseStarted(String courseId) => _startedCourseIds.contains(courseId);
}
