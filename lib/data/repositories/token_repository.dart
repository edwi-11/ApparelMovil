import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:apparel_movil/data/models/token_model.dart';

class TokenRepository {
  static const _key = 'session';

  String? _cachedToken;
  String? get currentToken => _cachedToken;

  Future<void> saveToken(TokenModel token) async {
    _cachedToken = token.token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(token.toJson()));
  }

  Future<TokenModel?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return null;
    final token = TokenModel.fromJson(jsonDecode(raw));
    _cachedToken = token.token;
    return token;
  }

  Future<void> clearToken() async {
    _cachedToken = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}