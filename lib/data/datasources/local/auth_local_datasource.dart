// lib/data/datasources/local/auth_local_datasource.dart

abstract class AuthLocalDataSource {
  Future<void> cacheAuthToken(String token);
  Future<String?> getAuthToken();
  Future<void> clearAuthToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  // Aquí se inyectaría la dependencia de 'shared_preferences' o 'flutter_secure_storage'
  // final SharedPreferences sharedPreferences;

  // AuthLocalDataSourceImpl(this.sharedPreferences);

  // Simulación para fines del ejemplo
  String? _cachedToken;

  @override
  Future<void> cacheAuthToken(String token) async {
    // await sharedPreferences.setString('auth_token', token);
    _cachedToken = token;
    print('Token de autenticación guardado localmente');
  }

  @override
  Future<String?> getAuthToken() async {
    // return sharedPreferences.getString('auth_token');
    print('Token de autenticación recuperado localmente');
    return _cachedToken;
  }

  @override
  Future<void> clearAuthToken() async {
    // await sharedPreferences.remove('auth_token');
    _cachedToken = null;
    print('Token de autenticación eliminado localmente');
  }
}
