// lib/data/repositories/auth_repository_impl.dart

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> registerWithEmailAndPassword(
    String email,
    String password,
    String role,
  ) async {
    final userModel = await remoteDataSource.registerWithEmailAndPassword(
      email,
      password,
      role,
    );
    return userModel; // UserModel hereda de UserEntity, por lo que es seguro devolverlo
  }

  @override
  Future<UserEntity> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final userModel = await remoteDataSource.signInWithEmailAndPassword(
      email,
      password,
    );
    return userModel;
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final userModel = await remoteDataSource.getCurrentUser();
    return userModel;
  }
}
