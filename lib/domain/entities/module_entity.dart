// lib/domain/entities/module_entity.dart

import 'package:equatable/equatable.dart';

class ModuleEntity extends Equatable {
  final String id;
  final String courseId;
  final String title;
  final String? description;
  final int orderIndex;

  const ModuleEntity({
    required this.id,
    required this.courseId,
    required this.title,
    this.description,
    required this.orderIndex,
  });

  @override
  List<Object?> get props => [id, courseId, title, description, orderIndex];
}
