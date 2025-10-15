// lib/presentation/screens/admin/admin_reports_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/injection_container.dart' as di;
import '../../../domain/usecases/reports/generate_pdf_report_usecase.dart';
import '../../providers/auth_provider.dart';

class AdminReportsScreen extends StatelessWidget {
  const AdminReportsScreen({super.key});

  Future<void> _generateReport(BuildContext context) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final user = auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes iniciar sesión para generar reportes.')),
      );
      return;
    }
    try {
      final usecase = di.sl<GeneratePdfReportUsecase>();
      final bytes = await usecase.call(user.uid);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reporte generado (${bytes.length} bytes).')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al generar el reporte: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Generar Reportes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reportes de Progreso',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            const Text(
              'Genera un reporte PDF con un resumen de microformaciones. ' 
              'En futuras versiones podrás descargar y compartir el archivo.',
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Generar reporte PDF'),
              onPressed: () => _generateReport(context),
            ),
          ],
        ),
      ),
    );
  }
}
