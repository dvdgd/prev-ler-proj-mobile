import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prev_ler/src/shared/errors/base_error.dart';

enum _SecureKeys {
  bearerToken(key: 'jwt_token'),
  password(key: 'password');

  final String key;

  const _SecureKeys({required this.key});
}

class SecureStore {
  final FlutterSecureStorage _storage;

  SecureStore(this._storage);

  Future<String> _getKey(String key) async {
    final value = await _storage.read(key: key);

    if (value == null) {
      throw UnknowError(detailedMessage: 'Key $key not found.');
    }

    return value;
  }

  Future<bool> containsBearer() async {
    final bearer = await _storage.containsKey(key: _SecureKeys.bearerToken.key);
    return bearer;
  }

  Future<void> saveBearer(String bearerToken) async {
    await _storage.write(key: _SecureKeys.bearerToken.key, value: bearerToken);
  }

  Future<String> getBearer() async {
    return _getKey(_SecureKeys.bearerToken.key);
  }

  Future<void> saveUserPassword(String password) async {
    await _storage.write(key: _SecureKeys.password.key, value: password);
  }

  Future<String> getPassword() async {
    return _getKey(_SecureKeys.password.key);
  }

  Future<void> deleteBearerAndPassword() async {
    Future.wait([
      _storage.delete(key: _SecureKeys.bearerToken.key),
      _storage.delete(key: _SecureKeys.password.key),
    ]);
  }
}
