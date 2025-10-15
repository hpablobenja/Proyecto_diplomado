// lib/domain/usecases/content/create_lesson_usecase.dart

import '../../entities/lesson_entity.dart';
import '../../repositories/content_repository.dart';
import '../usecase.dart';

class CreateLessonUsecase implements Usecase<LessonEntity, LessonEntity> {
  final ContentRepository repository;
  CreateLessonUsecase(this.repository);

  @override
  Future<LessonEntity> call(LessonEntity params) {
    return repository.createLesson(params);
  }
}
