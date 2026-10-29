import 'package:apparel_movil/core/constants/api_constants.dart';
import '../../core/network/api_client.dart';
import '../models/token_model.dart';
import 'package:apparel_movil/core/errors/app_exception.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<TokenModel> login(String usuarioLogin, String contrasena) async {
    final json = await _apiClient.post(
      ApiConstants.login,
      body: {
        'usuarioLogin': usuarioLogin,
        'contraseña': contrasena,
      },
    );

    if (json is! Map<String, dynamic>) throw ParsingException();
    
    return TokenModel.fromJson(json);

     }

     
}