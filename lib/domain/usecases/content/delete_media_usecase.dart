// lib/domain/usecases/content/delete_media_usecase.dart

import '../../repositories/content_repository.dart';
import '../usecase.dart';

class DeleteMediaParams {
  final String courseId;
  final String? moduleId;
  final String? lessonId;
  final String mediaId; // storage path used as id
  DeleteMediaParams({
    required this.courseId,
    this.moduleId,
    this.lessonId,
    required this.mediaId,
  });
}

class DeleteMediaUsecase implements Usecase<void, DeleteMediaParams> {
  final ContentRepository repository;
  DeleteMediaUsecase(this.repository);

  @override
  Future<void> call(DeleteMediaParams params) {
    return repository.deleteMedia(
      courseId: params.courseId,
      moduleId: params.moduleId,
      lessonId: params.lessonId,
      mediaId: params.mediaId,
    );
  }
}
