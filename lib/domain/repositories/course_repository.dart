// lib/domain/repositories/course_repository.dart

import '../entities/course_entity.dart';

abstract class CourseRepository {
  Future<List<CourseEntity>> getCourses();
  Future<CourseEntity> createCourse(CourseEntity course);
  // Aquí se agregarían los métodos para editar, eliminar, buscar, etc.
}
