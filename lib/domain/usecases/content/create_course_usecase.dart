// lib/domain/usecases/content/create_course_usecase.dart

import '../../entities/course_entity.dart';
import '../../repositories/content_repository.dart';
import '../usecase.dart';

class CreateCourseUsecase implements Usecase<CourseEntity, CourseEntity> {
  final ContentRepository repository;
  CreateCourseUsecase(this.repository);

  @override
  Future<CourseEntity> call(CourseEntity params) {
    return repository.createCourse(params);
  }
}
