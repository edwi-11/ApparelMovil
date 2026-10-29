import 'package:apparel_movil/data/models/token_model.dart';
import 'package:apparel_movil/data/repositories/auth_repository.dart';
import 'package:apparel_movil/data/repositories/token_repository.dart';
class Authservice {
  final AuthRepository _authRepository;
  final TokenRepository _tokenRepository;

  Authservice(this._authRepository, this._tokenRepository);

    Future<TokenModel> login(String usuarioLogin, String contrasena) async {
    final token = await _authRepository.login(usuarioLogin, contrasena);
    await _tokenRepository.saveToken(token);
    return token;

}
}