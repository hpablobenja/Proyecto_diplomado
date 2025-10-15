// lib/domain/usecases/content/delete_module_usecase.dart

import '../../repositories/content_repository.dart';
import '../usecase.dart';

class DeleteModuleParams {
  final String courseId;
  final String moduleId;
  DeleteModuleParams({required this.courseId, required this.moduleId});
}

class DeleteModuleUsecase implements Usecase<void, DeleteModuleParams> {
  final ContentRepository repository;
  DeleteModuleUsecase(this.repository);

  @override
  Future<void> call(DeleteModuleParams params) {
    return repository.deleteModule(params.courseId, params.moduleId);
  }
}
