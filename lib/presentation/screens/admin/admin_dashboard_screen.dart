// lib/presentation/screens/admin/admin_dashboard_screen.dart

import 'package:flutter/material.dart';

import '../admin/course_management_screen.dart';
import '../../widgets/app_drawer.dart';

class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Panel de Administración')),
      drawer: const AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bienvenido, Administrador',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CourseManagementScreen(),
                  ),
                );
              },
              child: Text('Gestionar Cursos'),
            ),
          ],
        ),
      ),
    );
  }
}
