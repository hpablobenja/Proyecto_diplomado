// lib/domain/entities/media_resource.dart

class MediaResource {
  final String id;
  final String url;
  final String filename;
  final String mimeType; // e.g., video/mp4, image/png, application/pdf
  final int sizeBytes;
  final Duration? duration; // for audio/video
  final Map<String, dynamic>? metadata; // thumbnails, width/height, etc.

  const MediaResource({
    required this.id,
    required this.url,
    required this.filename,
    required this.mimeType,
    required this.sizeBytes,
    this.duration,
    this.metadata,
  });
}

class MediaUploadRequest {
  final String filename;
  final String mimeType;
  final List<int> bytes;

  const MediaUploadRequest({
    required this.filename,
    required this.mimeType,
    required this.bytes,
  });
}
