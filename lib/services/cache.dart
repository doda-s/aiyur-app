import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static const String _timeSuffix = "_cache_time";

  // ---------- SINGLETON ----------
  CacheService._internal(); // construtor privado

  static final CacheService _instance = CacheService._internal();

  factory CacheService() => _instance;
  // Agora você usa: CacheService() em qualquer lugar
  // e sempre terá a MESMA instância
  // --------------------------------

  /// Salva dados em cache (qualquer JSON válido)
  Future<void> save(String key, dynamic data, {Duration? ttl}) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = jsonEncode(data);
    await prefs.setString(key, jsonString);

    if (ttl != null) {
      final expireAt =
          DateTime.now().millisecondsSinceEpoch + ttl.inMilliseconds;
      await prefs.setInt(key + _timeSuffix, expireAt);
    }
  }

  /// Carrega dados do cache (retorna Map ou List dependendo do conteúdo)
  Future<dynamic> load(String key) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(key);
    if (jsonString == null) return null;

    final expireAt = prefs.getInt(key + _timeSuffix);
    if (expireAt != null) {
      final now = DateTime.now().millisecondsSinceEpoch;

      if (now > expireAt) {
        await remove(key);
        return null;
      }
    }

    return jsonDecode(jsonString);
  }

  /// Remove um item específico do cache
  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    await prefs.remove(key + _timeSuffix);
  }

  /// Limpa todo o cache da aplicação
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// Converte Map<String, dynamic> → Map<int, String>
  Map<int, String> convertToIntMap(dynamic json) {
    if (json is! Map) return {};
    return json.map<int, String>(
      (key, value) => MapEntry(int.parse(key.toString()), value.toString()),
    );
  }
}
