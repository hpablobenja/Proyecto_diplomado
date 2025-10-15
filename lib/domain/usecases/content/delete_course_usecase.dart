// lib/domain/usecases/content/delete_course_usecase.dart

import '../../repositories/content_repository.dart';
import '../usecase.dart';

class DeleteCourseParams {
  final String courseId;
  DeleteCourseParams(this.courseId);
}

class DeleteCourseUsecase implements Usecase<void, DeleteCourseParams> {
  final ContentRepository repository;
  DeleteCourseUsecase(this.repository);

  @override
  Future<void> call(DeleteCourseParams params) {
    return repository.deleteCourse(params.courseId);
  }
}
