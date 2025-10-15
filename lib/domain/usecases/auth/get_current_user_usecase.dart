// lib/domain/usecases/auth/get_current_user_usecase.dart

import '../usecase.dart';
import '../../entities/user_entity.dart';
import '../../repositories/auth_repository.dart';

class GetCurrentUserUsecase implements Usecase<UserEntity?, NoParams> {
  final AuthRepository repository;

  GetCurrentUserUsecase(this.repository);

  @override
  Future<UserEntity?> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
