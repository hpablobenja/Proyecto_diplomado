// lib/presentation/widgets/video_preview_card.dart

import 'package:flutter/material.dart';

import '../../domain/entities/media_resource.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';

class VideoPreviewCard extends StatelessWidget {
  final MediaResource video;
  final VoidCallback? onTap;
  final bool showActions;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const VideoPreviewCard({
    super.key,
    required this.video,
    this.onTap,
    this.showActions = false,
    this.onEdit,
    this.onDelete,
  });

  String? _extractVideoId(MediaResource media) {
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

  String _getThumbnailUrl(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/mqdefault.jpg';
  }

  // ... (previous imports and class definition remain the same)

  @override
  Widget build(BuildContext context) {
    final videoId = _extractVideoId(video);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (videoId != null) ...[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(_getThumbnailUrl(videoId)),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {
                        // Fallback to placeholder if thumbnail fails to load
                      },
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.play_circle_outline,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                  ),
                ),
              ),
            ] else ...[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                    color: Colors.grey,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.video_library,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video.filename,
                          style: AppStyles.bodyText1.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                      ],
                    ),
                  ),
                  if (showActions) ...[
                    if (onEdit != null)
                      IconButton(
                        onPressed: onEdit,
                        icon: const Icon(Icons.edit_outlined),
                        tooltip: 'Editar video',
                        iconSize: 20,
                      ),
                    if (onDelete != null)
                      IconButton(
                        onPressed: onDelete,
                        icon: const Icon(Icons.delete_outline),
                        tooltip: 'Eliminar video',
                        iconSize: 20,
                        color: AppColors.errorColor,
                      ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
