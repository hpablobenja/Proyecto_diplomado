// lib/presentation/screens/courses/courses_list_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/course_provider.dart';
import '../../widgets/course_card.dart';
import '../../widgets/app_drawer.dart';

class CoursesListScreen extends StatefulWidget {
  @override
  State<CoursesListScreen> createState() => _CoursesListScreenState();
}

class _CoursesListScreenState extends State<CoursesListScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar los cursos una sola vez al entrar a la pantalla
    Future.microtask(() => context.read<CourseProvider>().loadCourses());
  }

  Future<void> _onRefresh() async {
    await context.read<CourseProvider>().loadCourses();
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Microformaciones')),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: courseProvider.isLoading
            ? ListView(children: const [SizedBox(height: 300), Center(child: CircularProgressIndicator())])
            : courseProvider.courses.isEmpty
                ? ListView(children: const [SizedBox(height: 300), Center(child: Text('No hay microformaciones disponibles.'))])
                : ListView.builder(
                    itemCount: courseProvider.courses.length,
                    itemBuilder: (context, index) {
                      final course = courseProvider.courses[index];
                      return CourseCard(course: course);
                    },
                  ),
      ),
    );
  }
}
