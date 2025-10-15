// lib/core/utils/firebase_utils.dart

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUtils {
  static String handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No se encontró un usuario con ese correo electrónico.';
      case 'wrong-password':
        return 'Contraseña incorrecta. Por favor, intente de nuevo.';
      case 'email-already-in-use':
        return 'El correo electrónico ya está en uso.';
      case 'invalid-email':
        return 'La dirección de correo electrónico es inválida.';
      default:
        return 'Ocurrió un error inesperado. Por favor, intente de nuevo más tarde.';
    }
  }
}
