// lib/presentation/providers/progress_provider.dart

import 'package:flutter/material.dart';

import '../../domain/usecases/courses/get_course_progress_usecase.dart';
import '../../domain/entities/course_entity.dart';

class ProgressProvider extends ChangeNotifier {
  final GetCourseProgressUsecase getCourseProgressUsecase;

  ProgressProvider({required this.getCourseProgressUsecase});

  bool _isLoading = false;
  String? _errorMessage;
  List<CourseEntity> _completedCourses = [];
  List<CourseEntity> _inProgressCourses = [];
  bool _hasViewedAnyLesson = false; // session flag

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<CourseEntity> get completedCourses => _completedCourses;
  List<CourseEntity> get inProgressCourses => _inProgressCourses;
  bool get hasViewedAnyLesson => _hasViewedAnyLesson;

  Future<void> loadUserProgress(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userProgress = await getCourseProgressUsecase.call(userId);
      _completedCourses = userProgress.completedCourses;
      _inProgressCourses = userProgress.inProgressCourses;
    } catch (e) {
      _errorMessage = 'No se pudo cargar el progreso del usuario. $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Marca que el usuario visualizó al menos una lección (fin de video)
  void markAnyLessonViewed() {
    if (!_hasViewedAnyLesson) {
      _hasViewedAnyLesson = true;
      notifyListeners();
    }
  }
}
