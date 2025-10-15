// lib/domain/usecases/courses/get_course_progress_usecase.dart

import '../usecase.dart';
import '../../entities/course_entity.dart';
import '../../repositories/course_repository.dart';

// Esta entidad representaría el progreso de un usuario.
// Se necesitaría crear una entidad y un repositorio de progreso.
// Por simplicidad, aquí simulamos el retorno de una lista de cursos.
class UserProgress {
  final List<CourseEntity> completedCourses;
  final List<CourseEntity> inProgressCourses;

  UserProgress({
    required this.completedCourses,
    required this.inProgressCourses,
  });
}

class GetCourseProgressUsecase implements Usecase<UserProgress, String> {
  final CourseRepository repository;

  GetCourseProgressUsecase(this.repository);

  @override
  Future<UserProgress> call(String userId) async {
    // Lógica para obtener el progreso del usuario desde el repositorio de progreso.
    // Aquí se simula el resultado para el ejemplo.
    final allCourses = await repository.getCourses();
    final completed =
        allCourses.where((c) => c.title.contains('Flutter')).toList();
    final inProgress =
        allCourses.where((c) => c.title.contains('Firebase')).toList();

    return UserProgress(
      completedCourses: completed,
      inProgressCourses: inProgress,
    );
  }
}
