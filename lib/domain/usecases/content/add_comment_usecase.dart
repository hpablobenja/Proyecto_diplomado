// lib/domain/usecases/content/add_comment_usecase.dart

import '../../entities/comment_entity.dart';
import '../../repositories/content_repository.dart';

class AddCommentUsecase {
  final ContentRepository repo;
  AddCommentUsecase(this.repo);

  Future<CommentEntity> call(CommentEntity comment) {
    return repo.addComment(comment);
  }
}
