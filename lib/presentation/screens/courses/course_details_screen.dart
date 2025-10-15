// lib/presentation/screens/courses/course_details_screen.dart

import 'package:flutter/material.dart';

import '../../../domain/entities/course_entity.dart';
import '../../../core/constants/app_colors.dart';
import 'course_content_view_screen.dart';

class CourseDetailsScreen extends StatelessWidget {
  final CourseEntity course;

  const CourseDetailsScreen({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              course.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Descripción',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              course.description,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (_) => CourseContentViewScreen(
                            courseId: course.id,
                            courseTitle: course.title,
                          ),
                    ),
                  );
                },
                icon: const Icon(Icons.play_circle_fill),
                label: const Text('Comenzar Microformación'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
