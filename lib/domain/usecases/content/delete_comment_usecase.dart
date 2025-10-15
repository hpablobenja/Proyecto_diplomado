// lib/domain/usecases/content/delete_comment_usecase.dart

import '../../repositories/content_repository.dart';

class DeleteCommentParams {
  final String courseId;
  final String moduleId;
  final String lessonId;
  final String commentId;
  DeleteCommentParams({
    required this.courseId,
    required this.moduleId,
    required this.lessonId,
    required this.commentId,
  });
}

class DeleteCommentUsecase {
  final ContentRepository repo;
  DeleteCommentUsecase(this.repo);

  Future<void> call(DeleteCommentParams params) {
    return repo.deleteComment(
      courseId: params.courseId,
      moduleId: params.moduleId,
      lessonId: params.lessonId,
      commentId: params.commentId,
    );
  }
}
