// lib/presentation/providers/auth_provider.dart

import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../../domain/usecases/auth/register_usecase.dart';
import '../../domain/usecases/auth/get_current_user_usecase.dart';
import '../../domain/usecases/usecase.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final GetCurrentUserUsecase getCurrentUserUsecase;

  AuthProvider({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.getCurrentUserUsecase,
  });

  bool _isLoading = false;
  String? _errorMessage;
  UserEntity? _currentUser;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserEntity? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await loginUsecase.call(
        LoginParams(email: email, password: password),
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage =
          e.toString(); // Manejar errores específicos de Firebase aquí
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> registerWithEmailAndPassword(
    String email,
    String password,
    String role,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await registerUsecase.call(
        RegisterParams(email: email, password: password, role: role),
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> checkCurrentUser() async {
    _isLoading = true;
    notifyListeners();
    _currentUser = await getCurrentUserUsecase.call(NoParams());
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    _currentUser = null;
    notifyListeners();
  }
}
