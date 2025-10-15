// lib/domain/usecases/courses/create_course_usecase.dart

import '../usecase.dart';
import '../../entities/course_entity.dart';
import '../../repositories/course_repository.dart';

class CreateCourseUsecase implements Usecase<CourseEntity, CreateCourseParams> {
  final CourseRepository repository;

  CreateCourseUsecase(this.repository);

  @override
  Future<CourseEntity> call(CreateCourseParams params) async {
    // Aquí se podría agregar lógica de negocio adicional,
    // como validaciones antes de llamar al repositorio.
    final newCourse = CourseEntity(
      id: '', // Firestore generará el ID
      title: params.title,
      description: params.description,
    );
    return await repository.createCourse(newCourse);
  }
}

class CreateCourseParams {
  final String title;
  final String description;

  CreateCourseParams({required this.title, required this.description});
}
