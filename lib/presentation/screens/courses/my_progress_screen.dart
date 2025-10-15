// lib/presentation/screens/courses/my_progress_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  void _generateReport() async {
    final generatePdfReportUsecase = di.sl<GeneratePdfReportUsecase>();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Generando reporte PDF...'),
        backgroundColor: AppColors.primaryColor,
      ),
    );

    try {
      final pdfBytes = await generatePdfReportUsecase.call(
        authProvider.currentUser!.uid,
      );
      // Aquí se implementaría la lógica para guardar o compartir el archivo
      // Por ejemplo, usando paquetes como 'path_provider' y 'open_filex'
      print('Reporte PDF generado, tamaño: ${pdfBytes.length} bytes');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Reporte PDF generado exitosamente.'),
          backgroundColor: AppColors.successColor,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
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
    final bool canGenerateReport = progressProvider.completedCourses.isNotEmpty;

    return Scaffold(
      drawer: AppDrawer(),
      body:
          progressProvider.isLoading
              ? Center(child: CircularProgressIndicator())
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

                    Center(
                      child: Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed:
                                canGenerateReport ? _generateReport : null,
                            icon: const Icon(Icons.picture_as_pdf),
                            label: Text(
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
                          if (!canGenerateReport)
                            Text(
                              'Genera tu primer reporte cuando completes una microformación (visualiza al menos un video).',
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
}
