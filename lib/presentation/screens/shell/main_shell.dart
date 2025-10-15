// lib/presentation/screens/shell/main_shell.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_styles.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/course_provider.dart';
import '../../providers/auth_provider.dart';
import '../courses/my_progress_screen.dart';
import '../profile/profile_screen.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/course_video_tile.dart';
import '../../providers/favorites_provider.dart';
import '../courses/course_details_screen.dart';

class MainShell extends StatefulWidget {
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    // Pre-cargar contenido para la galería
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CourseProvider>().loadCourses();
    });
  }

  void _onItemTapped(int index) {
    if (_currentIndex == index) {
      // Si ya está en la misma pestaña, hacer scroll al inicio
      _navigatorKey.currentState?.popUntil((route) => route.isFirst);
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final isMaestro = authProvider.currentUser?.role == 'maestro';

    return PopScope(
      canPop: _currentIndex == 0, // Solo permite salir si está en Formaciones
      onPopInvoked: (didPop) {
        if (!didPop) {
          // Si no se puede salir, volver a Formaciones
          _onItemTapped(0);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _titleForIndex(_currentIndex),
            style: AppStyles.headlineMedium.copyWith(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: const Color.fromARGB(
            255,
            145,
            124,
            217,
          ), //255, 74, 165, 95
        ),
        drawer: isMaestro ? null : const AppDrawer(),
        body: Navigator(
          key: _navigatorKey,
          onGenerateRoute: (settings) {
            return PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) =>
                      _buildCurrentPage(),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryBlue,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Formaciones',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritos'),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Progreso',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return const _GalleryScreen();
      case 1:
        return const _SearchScreen();
      case 2:
        return const _FavoritesScreen();
      case 3:
        return MyProgressScreen();
      case 4:
        return ProfileScreen();
      default:
        return const _GalleryScreen();
    }
  }

  String _titleForIndex(int index) {
    switch (index) {
      case 0:
        return 'Formaciones';
      case 1:
        return 'Buscar';
      case 2:
        return 'Favoritos';
      case 3:
        return 'Mi Progreso';
      case 4:
        return 'Mi Perfil';
      default:
        return '';
    }
  }
}

// ===== Gallery =====
class _GalleryScreen extends StatelessWidget {
  const _GalleryScreen();

  // En main_shell.dart, reemplaza el método build de _GalleryScreen con esto:

  @override
  Widget build(BuildContext context) {
    final courseProvider = context.watch<CourseProvider>();

    if (courseProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (courseProvider.courses.isEmpty) {
      return Center(
        child: Text(
          'Aún no hay microformaciones. Vuelve más tarde.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      );
    }

    // Filtros temáticos de ejemplo
    final filters = const ['Primaria', 'Secundaria', 'Especial'];

    return Container(
      // Hacer el fondo transparente para que se vea la imagen de fondo
      color: Colors.transparent,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final f in filters)
                    FilterChip(
                      label: Text(
                        f,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      selected: false,
                      onSelected: (_) {},
                      backgroundColor: Colors.white,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: AppColors.primaryColor.withOpacity(0.2),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final course = courseProvider.courses[index];
                return CourseVideoTile(
                  course: course,
                  onTap: () {
                    context.read<FavoritesProvider>().markCourseStarted(
                      course.id,
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CourseDetailsScreen(course: course),
                      ),
                    );
                  },
                );
              }, childCount: courseProvider.courses.length),
            ),
          ),
        ],
      ),
    );
  }
}

// ===== Search =====
class _SearchScreen extends StatelessWidget {
  const _SearchScreen();

  @override
  Widget build(BuildContext context) {
    return _SearchBody();
  }
}

class _SearchBody extends StatefulWidget {
  @override
  State<_SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<_SearchBody> {
  String query = '';
  final Set<String> chips = {};

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (v) => setState(() => query = v),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Busca por tema, nivel, duración…',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final label in const [
                      'Evaluación',
                      'Inclusión',
                      'Tecnología',
                      '<= 5 min',
                      'Primaria',
                      "Secundaria",
                    ])
                      FilterChip(
                        label: Text(
                          label,
                          style: const TextStyle(color: Colors.black),
                        ),
                        selected: chips.contains(label.toLowerCase()),
                        onSelected:
                            (sel) => setState(() {
                              final key = label.toLowerCase();
                              if (sel) {
                                chips.add(key);
                              } else {
                                chips.remove(key);
                              }
                            }),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Resultados',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
        _buildSearchResults(),
      ],
    );
  }

  Widget _buildSearchResults() {
    return Consumer<CourseProvider>(
      builder: (context, courseProvider, _) {
        final courses = courseProvider.courses;
        final filtered =
            courses.where((c) {
              final q = query.trim().toLowerCase();
              final matchesQuery =
                  q.isEmpty ||
                  c.title.toLowerCase().contains(q) ||
                  c.description.toLowerCase().contains(q);
              final matchesChip =
                  chips.isEmpty ||
                  chips.any(
                    (chip) =>
                        c.title.toLowerCase().contains(chip) ||
                        c.description.toLowerCase().contains(chip),
                  );
              return matchesQuery && matchesChip;
            }).toList();

        if (filtered.isEmpty) {
          return const SliverFillRemaining(
            child: Center(child: Text('No se encontraron resultados')),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final course = filtered[index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: CourseVideoTile(
                course: course,
                onTap: () {
                  context.read<FavoritesProvider>().markCourseStarted(
                    course.id,
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CourseDetailsScreen(course: course),
                    ),
                  );
                },
              ),
            );
          }, childCount: filtered.length),
        );
      },
    );
  }
}

// ===== Favorites =====
class _FavoritesScreen extends StatelessWidget {
  const _FavoritesScreen();

  @override
  Widget build(BuildContext context) {
    final courseProvider = context.watch<CourseProvider>();
    final favs = context.watch<FavoritesProvider>();
    final started = favs.startedCourseIds.toSet();
    final items =
        courseProvider.courses.where((c) => started.contains(c.id)).toList();

    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Aún no tienes favoritos.'),
            const SizedBox(height: 8),
            Text(
              'Inicia un curso desde Formaciones y aparecerá aquí.',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final course = items[index];
        return CourseVideoTile(
          course: course,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CourseDetailsScreen(course: course),
              ),
            );
          },
        );
      },
    );
  }
}
