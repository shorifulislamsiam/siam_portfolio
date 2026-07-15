/// All asset paths used in the portfolio.
/// Add new assets here and reference them via this class.
class AppAssets {
  AppAssets._();

  // ── Base Paths ─────────────────────────────────────────────────────────────
  static const String _images = 'assets/images/';
  static const String _icons = 'assets/icons/';
  static const String _lottie = 'assets/lottie/';
  static const String _svg = 'assets/svg/';

  // ── Images ─────────────────────────────────────────────────────────────────
  static const String profile = '${_images}profile.png';
  static const String logo = '${_images}logo.png';

  // ── Icons ──────────────────────────────────────────────────────────────────
  static const String iconFlutter = '${_icons}flutter.svg';
  static const String iconDart = '${_icons}dart.svg';
  static const String iconFirebase = '${_icons}firebase.svg';
  static const String iconGit = '${_icons}git.svg';
  static const String iconGithub = '${_icons}github.svg';
  static const String iconLinkedIn = '${_icons}linkedin.svg';
  static const String iconFacebook = '${_icons}facebook.svg';
  static const String iconEmail = '${_icons}email.svg';

  // ── Lottie ─────────────────────────────────────────────────────────────────
  static const String lottieSuccess = '${_lottie}success.json';
  static const String lottieLoading = '${_lottie}loading.json';
  static const String lottieNotFound = '${_lottie}not_found.json';

  // ── SVG ────────────────────────────────────────────────────────────────────
  static const String svgHeroDecoration = '${_svg}hero_decoration.svg';
}
