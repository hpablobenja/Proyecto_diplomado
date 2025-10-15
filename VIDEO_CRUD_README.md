# Sistema CRUD de Videos de YouTube

## Descripción

Se ha implementado un sistema completo de gestión de videos de YouTube para la aplicación RedMaestra. El sistema incluye:

- **Crear**: Agregar nuevos videos de YouTube a las lecciones
- **Leer**: Mostrar videos con previsualización y reproducción
- **Actualizar**: Editar URLs de videos existentes
- **Eliminar**: Remover videos de las lecciones

## Componentes Implementados

### 1. YouTubePlayerWidget (`lib/presentation/widgets/youtube_player_widget.dart`)
- Widget para reproducir videos de YouTube
- Soporte para autoplay y callback al finalizar
- Compatible con youtube_player_iframe v5.1.3

### 2. YouTubeVideoManager (`lib/presentation/widgets/youtube_video_manager.dart`)
- Gestión completa de videos de YouTube
- Interfaz para administradores y usuarios normales
- Funcionalidades CRUD completas
- Previsualización de videos

### 3. VideoPreviewCard (`lib/presentation/widgets/video_preview_card.dart`)
- Tarjeta de vista previa con thumbnail
- Muestra información del video
- Acciones de edición y eliminación

## Funcionalidades

### Para Administradores

1. **Agregar Videos**:
   - Botón "Gestionar videos" en cada lección
   - Diálogo para ingresar URL de YouTube
   - Validación automática de URLs
   - Soporte para múltiples formatos de URL

2. **Editar Videos**:
   - Cambiar URL del video
   - Mantener metadata del video
   - Validación de nueva URL

3. **Eliminar Videos**:
   - Confirmación antes de eliminar
   - Eliminación segura de la lección

4. **Previsualización**:
   - Thumbnails automáticos de YouTube
   - Información del video
   - Reproducción en línea

### Para Usuarios Normales

1. **Ver Videos**:
   - Lista de videos disponibles
   - Previsualización con thumbnails
   - Reproducción completa

2. **Navegación**:
   - Acceso desde pantalla de lección
   - Interfaz limpia sin opciones de edición

## URLs Soportadas

El sistema acepta los siguientes formatos de URL de YouTube:

- `https://www.youtube.com/watch?v=VIDEO_ID`
- `https://youtu.be/VIDEO_ID`
- `https://www.youtube.com/embed/VIDEO_ID`
- `https://www.youtube.com/shorts/VIDEO_ID`

## Uso

### En Pantalla de Administración

```dart
// En course_content_screen.dart
IconButton(
  tooltip: 'Gestionar videos',
  onPressed: () => _openVideoManager(module: m, lesson: l),
  icon: const Icon(Icons.video_library),
),
```

### En Pantalla de Usuario

```dart
// En lesson_player_screen.dart
YouTubeVideoManager(
  lesson: lesson,
  onLessonUpdated: (updatedLesson) {
    // Callback para actualizaciones (solo admin)
  },
  isAdmin: false,
),
```

### Widget de Vista Previa

```dart
VideoPreviewCard(
  video: mediaResource,
  onTap: () => _playVideo(video),
  showActions: isAdmin,
  onEdit: isAdmin ? () => _editVideo(video) : null,
  onDelete: isAdmin ? () => _deleteVideo(video) : null,
),
```

## Estructura de Datos

Los videos se almacenan como `MediaResource` con:

```dart
MediaResource(
  id: 'youtube:$videoId',
  url: 'https://www.youtube.com/watch?v=$videoId',
  filename: 'YouTube $videoId',
  mimeType: 'video/youtube',
  sizeBytes: 0,
  duration: null,
  metadata: {
    'provider': 'youtube',
    'videoId': videoId,
  },
)
```

## Características Técnicas

- **Validación**: URLs de YouTube validadas automáticamente
- **Thumbnails**: Generación automática de miniaturas
- **Responsive**: Diseño adaptable a diferentes tamaños de pantalla
- **Error Handling**: Manejo robusto de errores
- **Performance**: Carga lazy de videos y thumbnails

## Dependencias

- `youtube_player_iframe: ^5.1.3`
- `provider: ^6.1.0`
- `equatable: ^2.0.5`

## Notas de Implementación

1. Los videos se identifican por su `videoId` de YouTube
2. La metadata incluye información del proveedor para futuras extensiones
3. El sistema es extensible para otros proveedores de video
4. La interfaz se adapta según los permisos del usuario
5. Los thumbnails se cargan desde la API pública de YouTube 