// lib/domain/usecases/content/list_courses_usecase.dart

import '../../entities/course_entity.dart';
import '../../repositories/content_repository.dart';
import '../usecase.dart';

class ListCoursesUsecase implements Usecase<List<CourseEntity>, NoParams> {
  final ContentRepository repository;
  ListCoursesUsecase(this.repository);

  @override
  Future<List<CourseEntity>> call(NoParams params) {
    return repository.listCourses();
  }
}
