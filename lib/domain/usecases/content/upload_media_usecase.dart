// lib/domain/usecases/content/upload_media_usecase.dart

import '../../entities/media_resource.dart';
import '../../repositories/content_repository.dart';
import '../usecase.dart';

class UploadMediaParams {
  final String courseId;
  final String? moduleId;
  final String? lessonId;
  final MediaUploadRequest request;
  UploadMediaParams({
    required this.courseId,
    this.moduleId,
    this.lessonId,
    required this.request,
  });
}

class UploadMediaUsecase implements Usecase<MediaResource, UploadMediaParams> {
  final ContentRepository repository;
  UploadMediaUsecase(this.repository);

  @override
  Future<MediaResource> call(UploadMediaParams params) {
    return repository.uploadMedia(
      courseId: params.courseId,
      moduleId: params.moduleId,
      lessonId: params.lessonId,
      request: params.request,
    );
  }
}
