// lib/domain/usecases/content/list_comments_usecase.dart

import '../../entities/comment_entity.dart';
import '../../repositories/content_repository.dart';

class ListCommentsUsecase {
  final ContentRepository repo;
  ListCommentsUsecase(this.repo);

  Future<List<CommentEntity>> call({
    required String courseId,
    required String moduleId,
    required String lessonId,
  }) {
    return repo.listComments(courseId: courseId, moduleId: moduleId, lessonId: lessonId);
  }
}
