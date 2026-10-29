import 'package:apparel_movil/core/errors/app_exception.dart';
import 'package:flutter/material.dart';
import 'package:apparel_movil/services/auth_service.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthProvider extends ChangeNotifier {
  final Authservice _authService;
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
    notifyListeners();

    try {
      await _authService.login(username, password);
      _authStatus = AuthStatus.authenticated;

    }on AppException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = 'An unexpected error occurred. Please try again.';
    }

      _isSubmitting = false;
      notifyListeners();
  }
}