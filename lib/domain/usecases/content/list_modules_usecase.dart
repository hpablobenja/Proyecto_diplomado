// lib/domain/usecases/content/list_modules_usecase.dart

import '../../entities/module_entity.dart';
import '../../repositories/content_repository.dart';

class ListModulesUsecase {
  final ContentRepository repo;
  ListModulesUsecase(this.repo);

  Future<List<ModuleEntity>> call(String courseId) async {
    return repo.listModules(courseId);
  }
}
