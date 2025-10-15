// lib/domain/usecases/content/update_module_usecase.dart

import '../../entities/module_entity.dart';
import '../../repositories/content_repository.dart';
import '../usecase.dart';

class UpdateModuleUsecase implements Usecase<void, ModuleEntity> {
  final ContentRepository repository;
  UpdateModuleUsecase(this.repository);

  @override
  Future<void> call(ModuleEntity params) {
    return repository.updateModule(params);
  }
}
