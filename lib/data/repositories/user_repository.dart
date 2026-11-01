import 'package:apparel_movil/core/constants/api_constants.dart';
import 'package:apparel_movil/core/errors/app_exception.dart';
import 'package:apparel_movil/core/network/api_client.dart';
import 'package:apparel_movil/data/models/user_models.dart';

class UsuariosRepository {
  final dynamic _apiClient;

  UsuariosRepository(this._apiClient);

  Future<List<UsuarioModel>> obtenerTodos() async {
    try {
      final json = await _apiClient.get(ApiConstants.obtenerUsuarios);

      if (json is! List) throw ParsingException();

      return json
          .map((e) => UsuarioModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on NotFoundException {
      return []; 
    }
  }

  Future<UsuarioModel> obtenerPorCodigo(int cod) async {
    final json = await _apiClient.get(ApiConstants.verUsuario(cod));

    if (json is! Map<String, dynamic>) throw ParsingException();

    return UsuarioModel.fromJson(json);
  }

  Future<void> crear(UsuarioModel usuario) async {
    await _apiClient.post(ApiConstants.agregarUsuario, body: usuario.toJson());
  }

  Future<void> actualizar(UsuarioModel usuario) async {
    await _apiClient.put(
      ApiConstants.actualizarUsuario(usuario.codUsuario),
      body: usuario.toJson(),
    );
  }

  Future<void> darDeBaja(int cod) async {
    await _apiClient.delete(ApiConstants.darBajaUsuario(cod));
  }
}