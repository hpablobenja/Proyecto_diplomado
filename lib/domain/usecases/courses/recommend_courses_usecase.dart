// lib/domain/usecases/courses/recommend_courses_usecase.dart

import '../usecase.dart';
import '../../entities/course_entity.dart';
import '../../repositories/course_repository.dart';

class RecommendCoursesUsecase implements Usecase<List<CourseEntity>, String> {
  final CourseRepository repository;
  // Podría inyectarse un repositorio de perfil de usuario si es necesario
  // final UserProfileRepository userProfileRepository;

  RecommendCoursesUsecase(this.repository);

  @override
  Future<List<CourseEntity>> call(String userId) async {
    // 1. Obtener los cursos ya completados por el usuario
    // (Esto requeriría un repositorio de progreso)
    // final completedCourses = await userProgressRepository.getCompletedCourses(userId);

    // 2. Obtener el perfil del usuario (áreas de interés, etc.)
    // final userProfile = await userProfileRepository.getUserProfile(userId);

    // Lógica de recomendación simplificada:
    // Aquí se podría llamar a una API de Machine Learning o
    // implementar un algoritmo de reglas simples.
    // Por ejemplo:
    // - Sugerir los cursos más populares.
    // - Sugerir cursos con temas similares a los ya completados.
    // - Priorizar cursos que el usuario ha buscado pero no ha accedido.

    final allCourses = await repository.getCourses();

    // Simulación de recomendación: devuelve los 3 primeros cursos.
    if (allCourses.length > 3) {
      return allCourses.sublist(0, 3);
    }

    return allCourses;
  }
}
