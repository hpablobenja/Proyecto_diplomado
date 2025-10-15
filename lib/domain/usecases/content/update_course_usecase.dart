// lib/domain/usecases/content/update_course_usecase.dart

import '../../entities/course_entity.dart';
import '../../repositories/content_repository.dart';
import '../usecase.dart';

class UpdateCourseUsecase implements Usecase<CourseEntity, CourseEntity> {
  final ContentRepository repository;
  UpdateCourseUsecase(this.repository);

  @override
  Future<CourseEntity> call(CourseEntity params) {
    return repository.updateCourse(params);
  }
}
