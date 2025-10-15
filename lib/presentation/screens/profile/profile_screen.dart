// lib/presentation/screens/profile/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Mi Perfil'),
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
        ),
        body: Center(
          child: Text('No se pudo cargar la información del usuario.'),
        ),
      );
    }

    return Scaffold(
      appBar:
          user.role.toLowerCase() != 'maestro'
              ? CustomAppBar(title: 'Mi Perfil')
              : null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.primaryColor,
              child: Icon(Icons.person, size: 80, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              user.email,
              style: AppStyles.headline1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(
                user.role.toUpperCase(),
                style: AppStyles.buttonText.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              backgroundColor:
                  user.role == 'admin' ? Colors.red : AppColors.accentColor,
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.email, color: AppColors.primaryColor),
              title: Text('Correo Electrónico'),
              subtitle: Text(user.email),
            ),
            ListTile(
              leading: Icon(Icons.security, color: AppColors.primaryColor),
              title: Text('ID de Usuario'),
              subtitle: Text(user.uid),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                // Futura implementación: navegar a una pantalla de edición de perfil
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Funcionalidad de edición de perfil no implementada.',
                    ),
                    backgroundColor: Colors.grey,
                  ),
                );
              },
              icon: Icon(Icons.edit),
              label: Text('Editar Perfil'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentColor,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  await authProvider.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error al cerrar sesión: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              icon: Icon(Icons.logout),
              label: Text('Cerrar Sesión'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
