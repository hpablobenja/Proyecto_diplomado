// lib/domain/usecases/courses/search_courses_usecase.dart

import '../usecase.dart';
import '../../entities/course_entity.dart';
import '../../repositories/course_repository.dart';

class SearchCoursesUsecase implements Usecase<List<CourseEntity>, String> {
  final CourseRepository repository;

  SearchCoursesUsecase(this.repository);

  @override
  Future<List<CourseEntity>> call(String query) async {
    final allCourses = await repository.getCourses();

    // Lógica de búsqueda: filtra los cursos cuyo título o descripción
    // contengan la consulta de búsqueda.
    final filteredCourses =
        allCourses
            .where(
              (course) =>
                  course.title.toLowerCase().contains(query.toLowerCase()) ||
                  course.description.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
            )
            .toList();

    return filteredCourses;
  }
}
