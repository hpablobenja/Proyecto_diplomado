// lib/data/models/course_model.dart

import '../../domain/entities/course_entity.dart';

class CourseModel extends CourseEntity {
  final String? thumbnailUrl;

  const CourseModel({
    required String id,
    required String title,
    required String description,
    this.thumbnailUrl,
  }) : super(
          id: id,
          title: title,
          description: description,
          thumbnailUrl: thumbnailUrl,
        );

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      thumbnailUrl: map['thumbnailUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  @override
  CourseModel copyWith({
    String? id,
    String? title,
    String? description,
    String? thumbnailUrl,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }
}
