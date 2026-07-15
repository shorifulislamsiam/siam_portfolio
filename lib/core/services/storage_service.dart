import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService._();

  static SharedPreferences? _prefs;

  static const String clientsRole = 'CLIENTS';

  static const String _keyUserId = 'user_id';
  static const String _keyUserRole = 'user_role';
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isInitialized => _prefs != null;

  static SharedPreferences get prefs {
    final preferences = _prefs;
    if (preferences == null) {
      throw Exception(
        'StorageService not initialized. '
        'Call StorageService.init() in main() before runApp().',
      );
    }
    return preferences;
  }

  static Future<void> saveAuthData({
    required String userId,
    required String role,
    String? accessToken,
    String? token,
    String? refreshToken,
  }) async {
    final authToken = accessToken ?? token;
    if (authToken == null || authToken.isEmpty) {
      throw ArgumentError('accessToken is required.');
    }

    await Future.wait([
      setUserId(userId),
      setUserRole(role),
      setAccessToken(authToken),
      if (refreshToken != null && refreshToken.isNotEmpty)
        setRefreshToken(refreshToken),
    ]);
  }

  static Map<String, String?> getAuthData() {
    return {
      'userId': getUserId(),
      'role': getUserRole(),
      'accessToken': getAccessToken(),
      'refreshToken': getRefreshToken(),
    };
  }

  static Future<bool> setUserId(String userId) {
    return prefs.setString(_keyUserId, userId);
  }

  static String? getUserId() {
    return prefs.getString(_keyUserId);
  }

  static Future<bool> setUserRole(String role) {
    return prefs.setString(_keyUserRole, role);
  }

  static String? getUserRole() {
    return prefs.getString(_keyUserRole);
  }

  static Future<bool> setAccessToken(String token) {
    return prefs.setString(_keyAccessToken, token);
  }

  static String? getAccessToken() {
    return prefs.getString(_keyAccessToken);
  }

  static Future<bool> setRefreshToken(String token) {
    return prefs.setString(_keyRefreshToken, token);
  }

  static String? getRefreshToken() {
    return prefs.getString(_keyRefreshToken);
  }

  static bool hasToken() {
    final token = getAccessToken();
    return token != null && token.isNotEmpty;
  }

  static bool hasValidToken() {
    return hasToken();
  }

  static bool isLoggedIn() {
    return hasToken() && getUserId() != null;
  }

  static Future<void> logout() async {
    await clearAuthData();
  }

  static Future<void> clearAuthData() async {
    await Future.wait([
      prefs.remove(_keyUserId),
      prefs.remove(_keyUserRole),
      prefs.remove(_keyAccessToken),
      prefs.remove(_keyRefreshToken),
    ]);
  }

  static Future<bool> clearAll() {
    return prefs.clear();
  }

  // Old method names kept so other files can use the simple service easily.
  static Future<bool> setUserToken(String token) {
    return setAccessToken(token);
  }

  static String? getUserToken() {
    return getAccessToken();
  }
}
