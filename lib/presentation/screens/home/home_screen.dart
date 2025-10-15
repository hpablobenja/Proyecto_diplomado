// lib/presentation/screens/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../shell/main_shell.dart';
import '../admin/admin_dashboard_screen.dart';
import '../../widgets/back_home_button.dart';

// Import the main shell state key
final GlobalKey<NavigatorState> mainShellNavigatorKey = GlobalKey<NavigatorState>();

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    // Muestra una pantalla de carga si el usuario no ha sido cargado aún
    if (authProvider.currentUser == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Decide qué pantalla mostrar basándose en el rol del usuario
    return authProvider.currentUser!.role == 'admin'
        ? AdminDashboardScreen()
        : _HomeScaffold(
            child: MainShell(),
            showBackButton: authProvider.currentUser?.role == 'maestro',
          );
  }
}

class _HomeScaffold extends StatelessWidget {
  final Widget child;
  final bool showBackButton;

  const _HomeScaffold({
    required this.child,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (showBackButton)
          BackHomeButton(
            onPressed: () {
              // Use a navigation key to handle the back button press
              // This will be handled by the MainShell's navigation
              mainShellNavigatorKey.currentState?.pushNamedAndRemoveUntil(
                '/',
                (route) => false,
                arguments: {'tabIndex': 0}, // 0 is the index of Formaciones
              );
            },
          ),
      ],
    );
  }
}
