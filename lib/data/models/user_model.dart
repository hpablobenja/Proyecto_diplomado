// lib/data/models/user_model.dart

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String uid,
    required String email,
    required String role,
  }) : super(uid: uid, email: email, role: role);

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      role: map['role'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'role': role};
  }
}
