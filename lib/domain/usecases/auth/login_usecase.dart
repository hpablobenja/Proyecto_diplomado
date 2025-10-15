// lib/domain/usecases/auth/login_usecase.dart

import '../usecase.dart';
import '../../entities/user_entity.dart';
import '../../repositories/auth_repository.dart';

class LoginUsecase implements Usecase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  @override
  Future<UserEntity> call(LoginParams params) async {
    return await repository.signInWithEmailAndPassword(
      params.email,
      params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
