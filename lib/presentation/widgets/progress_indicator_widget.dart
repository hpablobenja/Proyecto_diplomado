// lib/presentation/widgets/progress_indicator_widget.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final double progress; // Valor entre 0.0 y 1.0
  final String label;

  const ProgressIndicatorWidget({
    Key? key,
    required this.progress,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.backgroundColor,
          color: AppColors.primaryColor,
        ),
        const SizedBox(height: 4),
        Text(
          '${(progress * 100).toStringAsFixed(0)}%',
          style: TextStyle(color: AppColors.textColor, fontSize: 14),
        ),
      ],
    );
  }
}
