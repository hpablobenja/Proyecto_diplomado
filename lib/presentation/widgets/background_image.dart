// lib/presentation/widgets/background_image.dart

import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final Widget child;
  final bool excludeLogin;
  final String imagePath;
  final double opacity;

  const BackgroundImage({
    super.key,
    required this.child,
    this.excludeLogin = true,
    this.imagePath = 'images/imagen_atras.jpg',
    this.opacity = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    // Check if we should exclude the background for login
    final isLoginScreen = ModalRoute.of(context)?.settings.name == '/login';
    if (excludeLogin && isLoginScreen) {
      return child;
    }

    // Create a stack with the background image and the child
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
                opacity: opacity,
              ),
            ),
          ),
        ),
        // Main content
        child,
      ],
    );
  }
}
