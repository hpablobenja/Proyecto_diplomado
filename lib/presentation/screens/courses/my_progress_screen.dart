// lib/presentation/screens/courses/my_progress_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../providers/progress_provider.dart';
import '../../providers/auth_provider.dart';
import '../../../core/injection_container.dart' as di;
import '../../../domain/usecases/reports/generate_pdf_report_usecase.dart';
import '../../widgets/app_drawer.dart';

class MyProgressScreen extends StatefulWidget {
  @override
  _MyProgressScreenState createState() => _MyProgressScreenState();
}

class _MyProgressScreenState extends State<MyProgressScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar el progreso del usuario al iniciar la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final progressProvider = Provider.of<ProgressProvider>(
        context,
        listen: false,
      );
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.currentUser != null) {
        progressProvider.loadUserProgress(authProvider.currentUser!.uid);
      }
    });
  }

  Future<void> _generateReport() async {
    final generatePdfReportUsecase = di.sl<GeneratePdfReportUsecase>();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Mostrar indicador de carga
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Text('Generando reporte PDF...'),
        backgroundColor: AppColors.primaryColor,
      ),
    );

    try {
      final pdfBytes = await generatePdfReportUsecase.call(
        authProvider.currentUser!.uid,
      );

      // Guardar el archivo PDF
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/documentos/reporte_usuario.pdf');
      await file.create(recursive: true);
      await file.writeAsBytes(pdfBytes);

      // Abrir el archivo PDF
      await OpenFilex.open(file.path);

      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Reporte PDF generado exitosamente.'),
          backgroundColor: AppColors.successColor,
        ),
      );
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Error al generar el reporte: $e'),
          backgroundColor: AppColors.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final progressProvider = Provider.of<ProgressProvider>(context);

    return Scaffold(
      drawer: const AppDrawer(),
      body:
          progressProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Sección de Cursos Completados
                    Text(
                      'Microformaciones Completadas',
                      style: AppStyles.headline1,
                    ),
                    const SizedBox(height: 16),

                    if (progressProvider.completedCourses.isEmpty)
                      _buildEmptyState(),

                    ...progressProvider.completedCourses.map(
                      (course) => ListTile(
                        leading: Icon(
                          Icons.check_circle,
                          color: AppColors.successColor,
                        ),
                        title: Text(
                          course.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Sección de Cursos en Curso
                    Text(
                      'Microformaciones en Curso',
                      style: AppStyles.headline1,
                    ),
                    const SizedBox(height: 16),
                    ...progressProvider.inProgressCourses.map(
                      (course) => ListTile(
                        leading: Icon(
                          Icons.access_time,
                          color: AppColors.accentColor,
                        ),
                        title: Text(
                          course.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Botón de Generar Reporte
                    Center(
                      child: Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: _generateReport,
                            icon: const Icon(Icons.picture_as_pdf),
                            label: const Text(
                              'Generar Reporte PDF',
                              style: AppStyles.buttonText,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Descargará el documento solicitado',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Colors.grey[700]),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Icon(Icons.school_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Aún no has completado ninguna microformación',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Completa al menos una microformación para ver tu progreso aquí',
            style: TextStyle(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
