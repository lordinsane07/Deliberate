import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Keys
  static const String _tokenKey = 'auth_token';
  static const String _aliasKey = 'user_alias';

  // Token
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return _storage.read(key: _tokenKey);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  // Alias
  static Future<void> saveAlias(String alias) async {
    await _storage.write(key: _aliasKey, value: alias);
  }

  static Future<String?> getAlias() async {
    return _storage.read(key: _aliasKey);
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
