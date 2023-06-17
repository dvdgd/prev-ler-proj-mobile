import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum _SecureKeys {
  bearerToken(key: 'jwt_token'),
  password(key: 'password');

  final String key;

  const _SecureKeys({required this.key});
}

class SecureStore {
  final FlutterSecureStorage storage;

  SecureStore(this.storage);

  Future<String> _getKey(String key) async {
    final value = await storage.read(key: key);

    if (value == null) {
      throw Exception('Key $key not found.');
    }

    return value;
  }

  Future<void> saveBearer(String bearerToken) async {
    await storage.write(key: _SecureKeys.bearerToken.key, value: bearerToken);
  }

  Future<String> getBearer() async {
    return _getKey(_SecureKeys.bearerToken.key);
  }

  Future<void> saveUserPassword(String password) async {
    await storage.write(key: _SecureKeys.password.key, value: password);
  }

  Future<String> getPassword() async {
    return _getKey(_SecureKeys.password.key);
  }

  Future<void> deleteBearerAndPassword() async {
    Future.wait([
      storage.delete(key: _SecureKeys.bearerToken.key),
      storage.delete(key: _SecureKeys.password.key),
    ]);
  }
}
