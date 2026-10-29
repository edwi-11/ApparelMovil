import 'package:apparel_movil/data/models/token_model.dart';
import 'package:apparel_movil/data/repositories/auth_repository.dart';
class Authservice {
  final AuthRepository _authRepository;

  Authservice(this._authRepository);

  Future<TokenModel> login(String usuarioLogin, String contrasena) async {
    return await _authRepository.login(usuarioLogin, contrasena);
  }

 
}