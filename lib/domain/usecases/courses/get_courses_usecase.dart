// lib/domain/usecases/courses/get_courses_usecase.dart

import '../usecase.dart';
import '../../entities/course_entity.dart';
import '../../repositories/course_repository.dart';

class GetCoursesUsecase implements Usecase<List<CourseEntity>, NoParams> {
  final CourseRepository repository;

  GetCoursesUsecase(this.repository);

  @override
  Future<List<CourseEntity>> call(NoParams params) async {
    return await repository.getCourses();
  }
}
