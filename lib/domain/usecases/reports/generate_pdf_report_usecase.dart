// lib/domain/usecases/reports/generate_pdf_report_usecase.dart

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../usecase.dart';
import '../../repositories/course_repository.dart';

class GeneratePdfReportUsecase implements Usecase<List<int>, String> {
  final CourseRepository courseRepository;
  // Se podría inyectar un repositorio de progreso aquí
  // final UserProgressRepository userProgressRepository;

  GeneratePdfReportUsecase(this.courseRepository);

  @override
  Future<List<int>> call(String userId) async {
    // 1. Crear un documento PDF
    final pdf = pw.Document();

    // 2. Obtener los datos del progreso del usuario (simulado)
    final allCourses = await courseRepository.getCourses();
    final completedCourses =
        allCourses.where((c) => c.title.contains('Flutter')).toList();
    final inProgressCourses =
        allCourses.where((c) => c.title.contains('Firebase')).toList();

    // 3. Definir la estructura del reporte
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Reporte de Progreso de Microformaciones',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Maestro: [Nombre del Maestro]',
              ), // Reemplazar con datos reales
              pw.SizedBox(height: 20),

              // Sección de Cursos Completados
              pw.Text(
                'Microformaciones Completadas',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              ...completedCourses.map((course) => pw.Text('- ${course.title}')),
              pw.SizedBox(height: 20),

              // Sección de Cursos en Curso
              pw.Text(
                'Microformaciones en Curso',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              ...inProgressCourses.map(
                (course) => pw.Text('- ${course.title}'),
              ),
            ],
          );
        },
      ),
    );

    // 4. Guardar y retornar el PDF como una lista de bytes
    return pdf.save();
  }
}
