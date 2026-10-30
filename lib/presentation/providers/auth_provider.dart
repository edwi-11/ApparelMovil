import 'package:apparel_movil/core/errors/app_exception.dart';
import 'package:flutter/material.dart';
import 'package:apparel_movil/services/auth_service.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  AuthProvider(this._authService);

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AuthStatus _authStatus = AuthStatus.unknown;

  AuthStatus get authStatus => _authStatus;

  bool get isAuthenticated => _authStatus == AuthStatus.authenticated;

  bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;

  Future<void> login({required String username, required String password}) async {
    if (_isSubmitting) return;
    _isSubmitting = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final session = await _authService.login(username, password);
      debugPrint('TOKEN: ${session.token}');
      debugPrint('CODUSUARIO: ${session.codUsuario}');
      _authStatus = AuthStatus.authenticated;

    } on AppException catch (e) {
      debugPrint('APP EXCEPTION: ${e.message}');
      _errorMessage = e.message;
      _authStatus = AuthStatus.unauthenticated;
    } catch (e, st) {
      debugPrint('LOGIN ERROR: $e');
      debugPrint('$st');
      _errorMessage = 'An unexpected error occurred. Please try again.';
      _authStatus = AuthStatus.unauthenticated;
    }

    _isSubmitting = false;
    notifyListeners();
  }
}