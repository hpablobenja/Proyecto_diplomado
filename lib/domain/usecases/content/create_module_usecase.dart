// lib/domain/usecases/content/create_module_usecase.dart

import '../../entities/module_entity.dart';
import '../../repositories/content_repository.dart';
import '../usecase.dart';

class CreateModuleUsecase implements Usecase<ModuleEntity, ModuleEntity> {
  final ContentRepository repository;
  CreateModuleUsecase(this.repository);

  @override
  Future<ModuleEntity> call(ModuleEntity params) {
    return repository.createModule(params);
  }
}
