// lib/domain/usecases/content/update_lesson_usecase.dart

import '../../entities/lesson_entity.dart';
import '../../repositories/content_repository.dart';
import '../usecase.dart';

class UpdateLessonUsecase implements Usecase<void, LessonEntity> {
  final ContentRepository repository;
  UpdateLessonUsecase(this.repository);

  @override
  Future<void> call(LessonEntity params) {
    return repository.updateLesson(params);
  }
}
