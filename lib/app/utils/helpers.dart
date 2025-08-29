import 'dart:developer';

/// Builds a sanitized YouTube watch URL (https://www.youtube.com/watch?v=ID)
/// from various possible inputs:
/// - Raw video ID (optionally with query like `?si=...`)
/// - youtu.be short links
/// - youtube.com/watch URLs
/// - youtube.com/shorts/ID
/// - youtube.com/embed/ID
///
/// Returns `null` if the input is null/empty or an ID cannot be determined.
Uri? buildYouTubeWatchUri(String? raw) {
  if (raw == null) return null;
  String value = raw.trim();
  if (value.isEmpty) return null;

  String id = value;

  // If the value is a full URL, parse and extract the video id.
  if (id.startsWith('http://') || id.startsWith('https://')) {
    try {
      final uri = Uri.parse(id);
      final host = uri.host.toLowerCase();

      if (host.contains('youtu.be')) {
        if (uri.pathSegments.isNotEmpty) {
          id = uri.pathSegments.first;
        }
      } else if (host.contains('youtube.com')) {
        if (uri.pathSegments.isNotEmpty) {
          final first = uri.pathSegments.first;
          if (first == 'watch') {
            id = uri.queryParameters['v'] ?? id;
          } else if (first == 'shorts' && uri.pathSegments.length >= 2) {
            id = uri.pathSegments[1];
          } else if (first == 'embed' && uri.pathSegments.length >= 2) {
            id = uri.pathSegments[1];
          } else {
            id = uri.queryParameters['v'] ?? id;
          }
        } else {
          id = uri.queryParameters['v'] ?? id;
        }
      }
    } catch (_) {
      // If parsing fails, fall back to treating it as a raw ID
    }
  } else {
    // If it's just an ID with optional query like "abc123?si=xyz"
    final qIndex = id.indexOf('?');
    if (qIndex > 0) {
      id = id.substring(0, qIndex);
    }
  }

  // Final safety: strip any remaining query portion if present
  id = id.split('?').first;
  if (id.isEmpty) return null;

  return Uri.https('www.youtube.com', '/watch', {'v': id});
}

String? extractYouTubeId(String? raw) {
  final uri = buildYouTubeWatchUri(raw);
  if (uri == null) return null;
  final id = uri.queryParameters['v'];
  if (id == null || id.isEmpty) return null;
  return id;
}

// Get youtube thumbnail image from url
String getYouTubeThumbnail(String? url) {
  final id = extractYouTubeId(url);
  if (id == null) return "";
  return 'https://i.ytimg.com/vi/$id/hqdefault.jpg';
}

String getVimeoId(String? raw) {
  if (raw == null || raw.trim().isEmpty) {
    log('No videoLink provided', name: 'vimeoId');
    return '';
  }

  String value = raw.trim();
  String id = value;

  // If the value is a full Vimeo URL, extract the video ID
  if (value.startsWith('http://') || value.startsWith('https://')) {
    try {
      final uri = Uri.parse(value);
      final host = uri.host.toLowerCase();

      if (host.contains('vimeo.com')) {
        if (uri.pathSegments.isNotEmpty) {
          id = uri.pathSegments.last;
        }
      }
    } catch (_) {
      // If parsing fails, fall back to treating it as a raw ID
      id = value;
    }
  }

  log(id, name: 'vimeoId');
  return id;
}
