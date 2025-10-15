// lib/domain/entities/course_entity.dart

import 'package:equatable/equatable.dart';

class CourseEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String? thumbnailUrl;

  const CourseEntity({
    required this.id,
    required this.title,
    required this.description,
    this.thumbnailUrl,
  });

  @override
  List<Object?> get props => [id, title, description, thumbnailUrl];

  CourseEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? thumbnailUrl,
  }) {
    return CourseEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }
}
