// lib/presentation/widgets/course_card.dart

import 'package:flutter/material.dart';

import '../../domain/entities/course_entity.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../screens/courses/course_details_screen.dart';

class CourseCard extends StatelessWidget {
  final CourseEntity course;

  const CourseCard({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.title,
              style: AppStyles.subhead1,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              course.description,
              style: AppStyles.bodyText1,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CourseDetailsScreen(course: course),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Ver Curso', style: AppStyles.buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
