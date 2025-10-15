// lib/presentation/screens/courses/lesson_player_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/lesson_entity.dart';
import '../../../domain/entities/media_resource.dart';
import '../../widgets/youtube_player_widget.dart';
import '../../providers/progress_provider.dart';
import '../../providers/comments_provider.dart';
import '../../providers/auth_provider.dart';

class LessonPlayerScreen extends StatefulWidget {
  final LessonEntity lesson;

  const LessonPlayerScreen({super.key, required this.lesson});

  @override
  State<LessonPlayerScreen> createState() => _LessonPlayerScreenState();
}

class _LessonPlayerScreenState extends State<LessonPlayerScreen> {
  final TextEditingController _commentCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load comments for this lesson on open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final comments = Provider.of<CommentsProvider>(context, listen: false);
      comments.load(
        courseId: widget.lesson.courseId,
        moduleId: widget.lesson.moduleId,
        lessonId: widget.lesson.id,
      );
    });
  }

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
  }

  String? _youtubeIdFromMedia(MediaResource media) {
    // 1) Prefer explicit metadata
    final meta = media.metadata;
    final metaId = meta is Map<String, dynamic> ? meta['videoId'] : null;
    if (metaId is String &&
        metaId.isNotEmpty &&
        RegExp(r'^[A-Za-z0-9_-]{11}$').hasMatch(metaId)) {
      return metaId;
    }

    // 2) Try to parse from URL
    final url = media.url;
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    // watch?v=ID
    final v = uri.queryParameters['v'];
    if (v != null && RegExp(r'^[A-Za-z0-9_-]{11}$').hasMatch(v)) return v;

    // youtu.be/ID or /embed/ID or /shorts/ID
    final path = uri.pathSegments;
    if (path.isNotEmpty) {
      if ((uri.host.contains('youtu.be') ||
              path.first == 'embed' ||
              path.first == 'shorts') &&
          RegExp(r'^[A-Za-z0-9_-]{11}$').hasMatch(path.last)) {
        return path.last;
      }
    }
    return null;
  }

  Future<void> _submitComment() async {
    final text = _commentCtrl.text.trim();
    if (text.isEmpty) return;
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final user = auth.currentUser;
    if (user == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inicia sesión para comentar')),
      );
      return;
    }

    final comments = Provider.of<CommentsProvider>(context, listen: false);
    final ok = await comments.add(
      courseId: widget.lesson.courseId,
      moduleId: widget.lesson.moduleId,
      lessonId: widget.lesson.id,
      userId: user.uid,
      userName: user.email,
      text: text,
    );
    if (!mounted) return;
    if (ok) {
      _commentCtrl.clear();
    } else if (comments.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(comments.error!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson;
    // Pick first YouTube media
    final ytMedia = lesson.media.firstWhere(
      (m) => m.mimeType == 'video/youtube',
      orElse: () => lesson.media.isNotEmpty
          ? lesson.media.first
          : const MediaResource(
              id: '',
              url: '',
              filename: '',
              mimeType: '',
              sizeBytes: 0,
              duration: null,
              metadata: <String, dynamic>{},
            ),
    );

    final videoId = ytMedia.mimeType == 'video/youtube'
        ? _youtubeIdFromMedia(ytMedia)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (videoId != null)
              YouTubePlayerWidget(
                videoId: videoId,
                autoPlay: false,
                onEnded: () {
                  // Marca visualización y notifica
                  Provider.of<ProgressProvider>(
                    context,
                    listen: false,
                  ).markAnyLessonViewed();
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Lección vista registrada.')),
                  );
                },
              )
            else
              const AspectRatio(
                aspectRatio: 16 / 9,
                child: Center(
                  child: Text('No hay video de YouTube disponible.'),
                ),
              ),
            const SizedBox(height: 16),
            // Comentarios embebidos
            Text('Comentarios', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Expanded(
              child: Consumer<CommentsProvider>(
                builder: (context, cp, _) {
                  if (cp.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (cp.items.isEmpty) {
                    return const Center(child: Text('Sé el primero en comentar.'));
                  }
                  return ListView.separated(
                    itemCount: cp.items.length,
                    separatorBuilder: (_, __) => const Divider(height: 8),
                    itemBuilder: (context, index) {
                      final c = cp.items[index];
                      return ListTile(
                        dense: true,
                        leading: const Icon(Icons.person_outline),
                        title: Text(c.userName),
                        subtitle: Text(c.text),
                        trailing: Text(
                          '${c.createdAt.day.toString().padLeft(2, '0')}/${c.createdAt.month.toString().padLeft(2, '0')}/${c.createdAt.year}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _commentCtrl,
              builder: (context, value, _) {
                return Consumer<AuthProvider>(
                  builder: (context, auth, __) {
                    final canSend = value.text.trim().isNotEmpty && auth.currentUser != null;
                    return Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _commentCtrl,
                            minLines: 1,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              hintText: 'Escribe un comentario...',
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.send),
                          color: canSend ? Theme.of(context).colorScheme.primary : Theme.of(context).disabledColor,
                          onPressed: canSend ? _submitComment : null,
                          tooltip: auth.currentUser == null ? 'Inicia sesión para comentar' : 'Publicar',
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
