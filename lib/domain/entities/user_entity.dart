// lib/domain/entities/user_entity.dart

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String role; // 'maestro' o 'admin'

  const UserEntity({
    required this.uid,
    required this.email,
    required this.role,
  });

  @override
  List<Object> get props => [uid, email, role];
}
