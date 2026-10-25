/// Data model for a portfolio project card.
class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String? githubUrl;
  final String? liveDemoUrl;
  final String? appStoreUrl;
  final String? playStoreUrl;
  final String category;
  final bool isFeatured;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    this.githubUrl,
    this.liveDemoUrl,
    this.appStoreUrl,
    this.playStoreUrl,
    required this.category,
    this.isFeatured = false,
  });

  /// Resolves the Apple App Store URL (either from appStoreUrl or detected in liveDemoUrl).
  String? get resolvedAppStoreUrl {
    if (appStoreUrl != null && appStoreUrl!.trim().isNotEmpty) {
      return appStoreUrl!.trim();
    }
    if (liveDemoUrl != null &&
        (liveDemoUrl!.contains('apps.apple.com') ||
            liveDemoUrl!.contains('itunes.apple.com'))) {
      return liveDemoUrl!.trim();
    }
    return null;
  }

  /// Resolves the Google Play Store URL (either from playStoreUrl or detected in liveDemoUrl).
  String? get resolvedPlayStoreUrl {
    if (playStoreUrl != null && playStoreUrl!.trim().isNotEmpty) {
      return playStoreUrl!.trim();
    }
    if (liveDemoUrl != null && liveDemoUrl!.contains('play.google.com')) {
      return liveDemoUrl!.trim();
    }
    return null;
  }

  /// Resolves generic Live Demo / Google Drive / Web preview URL.
  String? get resolvedLiveDemoUrl {
    if (liveDemoUrl == null || liveDemoUrl!.trim().isEmpty) return null;
    final trimmed = liveDemoUrl!.trim();
    if (trimmed.contains('apple.com') || trimmed.contains('play.google.com')) {
      return null;
    }
    return trimmed;
  }
}
